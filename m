Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B179CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8085810F259;
	Tue,  6 Oct 2026 09:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ae5qConT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F64110F26C
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 09:59:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 876686022A;
 Tue,  6 Oct 2026 09:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767CE1F000FF;
 Tue,  6 Oct 2026 09:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791280750;
 bh=oeSgVEToKy6aow+epXZMmyRWo4CwzKipH7QE77b9DmA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ae5qConTRtDe2EIx0Fu5mytBK9gV1JJiRo6uRYY+GrgDO0DE/2fxIIruK1KJZzk8+
 HHtGAwJB5SnrH22PoM7fEzLmlOqsgiAy4/h618HOGA9n7ecIsvaE6wjkrwjW3FrZsv
 i4Scab6FYfTaBLqipaxN5kQD6XL0ALCJMjDWbXIpubW5BMtL75tDKSJ/GSfodE2q/j
 1HFMU04fl6AR51BOh0pUtwO5hdU51ds/9LKUkcaJFEUvVuylUDwIvtjDn4zTG9rdDL
 rQCoRdJ+yh8+1gECoBOT1jkrlu4ZsF02Qo3+hfvStT6FjvXA0QsJa5dBnHTiSDlId0
 PG1RRixUloTpg==
Date: Tue, 6 Oct 2026 10:59:05 +0100
From: Daniel Thompson <danielt@kernel.org>
To: david@ixit.cz
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, Kiran Gunda <quic_kgunda@quicinc.com>,
 Marco Mattiolo <marco.mattiolo@hotmail.it>,
 =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Joel Selvaraj <foss@joelselvaraj.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/4] backlight: qcom-wled: Fix NULL pointer
 dereference in wled_remove()
Message-ID: <asTGaV_---60n_Kp@aspen.lan>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
 <20260921-qcom-wled-backlight-v4-1-bab8c7ef73cb@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-qcom-wled-backlight-v4-1-bab8c7ef73cb@ixit.cz>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, Sep 21, 2026 at 12:46:22PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
>
> wled_probe() doesn't set the driver data for the platform device.
> As a result, platform_get_drvdata() in wled_remove() will return NULL,
> and the first dereference of it crashes on unbind.
>
> Set the platform device driver data in wled_probe().
>
> Cc: stable@vger.kernel.org
> Fixes: feeab87b3072 ("backlight: qcom-wled: Add support for short circuit handling")
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
