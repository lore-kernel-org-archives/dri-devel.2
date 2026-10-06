Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2015CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 10:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3490710F273;
	Tue,  6 Oct 2026 10:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="in5/gS/p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A7410F273
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 10:11:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 405A84147C;
 Tue,  6 Oct 2026 10:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819081F000FF;
 Tue,  6 Oct 2026 10:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791281470;
 bh=6ifHIOS2ibXbICAWuA2UAm0iaz+kfT4Xg36obAXTmAA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=in5/gS/piEIPCVnPAt2SqOe+vA9noirB1QGF/7ggcePXIK7vQvsXKsWs9aSZOltrF
 0qB6ZIIgXNFBDskRrzc5Ci165FUILbgQrumXreLVimUorEbuGiGqhMciI1vM9dmsdD
 zRN3ShDMkSHD9Bw7NhdHyaGQsd6yNBd8TDEBYhbDkUc90TQJ8FFFyetMP/q8Lds3CE
 byvmtysqdcUo3bBf3I1eV14+8HCj8H1srLrkkP/3E4gcd4wzPnVyqab6LFvfNJ3kZ+
 abf2HRCi+WO0RVTNX5u1Qu6mpdORsmBCGsZPcAM6LT+amjaigNelNkBjyWG+ehTkLU
 /arNlFJFnWbag==
Date: Tue, 6 Oct 2026 11:11:04 +0100
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
 Joel Selvaraj <foss@joelselvaraj.com>
Subject: Re: [PATCH v4 4/4] backlight: qcom-wled: Read back the programmed
 brightness at probe
Message-ID: <asTJOGXnq3pixevl@aspen.lan>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
 <20260921-qcom-wled-backlight-v4-4-bab8c7ef73cb@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-qcom-wled-backlight-v4-4-bab8c7ef73cb@ixit.cz>
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

On Mon, Sep 21, 2026 at 12:46:25PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
>
> Since the previous change wled_probe() seeds wled->brightness from
> MOD_EN, but with default-brightness rather than the level the hardware
> is actually driving, so a backlight left lit by the bootloader still
> visibly steps on the first update, and actual_brightness reports the
> last value written rather than what the panel shows.
>
> Add wled_read_brightness(), which returns 0 when MOD_EN is clear and
> otherwise reads the brightness register the matching
> wledN_set_brightness() writes: the first enabled string on WLED3 and
> WLED4, the selected modulator on WLED5. Use it to seed both
> wled->brightness and the initial backlight property, and expose it as
> backlight_ops.get_brightness so that actual_brightness reflects the
> hardware too.
>
> A module that is enabled with the brightness registers at zero, which
> wled4_setup() and wled_auto_string_detection() can leave behind on a
> cold boot, now reads back as off. The OVP interrupt is then armed by the
> first brightness update rather than from probe, which is what happens
> on every other board where the module starts out disabled.
>
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Assisted-by: LLM
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
