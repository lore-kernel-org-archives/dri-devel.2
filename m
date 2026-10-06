Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD3ACA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 10:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3260110E29A;
	Tue,  6 Oct 2026 10:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J4E2WmoB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4AB410E29A
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 10:03:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DF1E43E12;
 Tue,  6 Oct 2026 10:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C611F000FF;
 Tue,  6 Oct 2026 10:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791281011;
 bh=fDfSAUXNlnIr8WhGRvDMtmNz3uXW9Ub9sCp+o+YIEYI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=J4E2WmoBNAWWEzyqtdOg6R49PtoxmBqlIA5re63CXl0ed/xEfz8rfwNmySrE8tbku
 J3EULoTZIk1Yyj45oBiT+/H/e83GkswqWHh7NmNmS6255egih+sGRvV0wbgcrMXSTY
 dRjfSOUMrm7LY8L0boU4+iP+16wpva/IsZwGLeAv6Y7Oqfa9vTS+kp6PzFULC8ffBL
 FVDc8o/3XyIxrVJ/jxdiFbMJLtaRNbilCDpuR7eJ0pCAWgpEOwaxywAmZClRKqiy1a
 JJTSxEawaasLYeQivVa7LxJlZw1vCUuDRvS6HZOvZsSA7/uR41s+qFqdeGjlMAVjUQ
 3qEZXdR1KaWZg==
Date: Tue, 6 Oct 2026 11:03:26 +0100
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
Subject: Re: [PATCH v4 2/4] backlight: qcom-wled: Fix WLED3 brightness
 register stride
Message-ID: <asTHbpMrXzjh_iyk@aspen.lan>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
 <20260921-qcom-wled-backlight-v4-2-bab8c7ef73cb@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-qcom-wled-backlight-v4-2-bab8c7ef73cb@ixit.cz>
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

On Mon, Sep 21, 2026 at 12:46:23PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
>
> WLED3 has a 16-bit brightness register pair per string, at 0x40 + 2*n,
> which is what the pm8941-wled driver wrote to:
>
> 	rc = regmap_bulk_write(wled->regmap,
> 			wled->addr + WLED3_CTRL_REG_VAL_BASE + 2 * i,
> 			v, 2);
>
> The restructuring for WLED3 turned that into WLED3_SINK_REG_BRIGHT(n),
> defined as 0x40 + n, so the two byte writes for consecutive strings
> overlap: string 1 overwrites the MSB of string 0 with its own LSB, and
> with the default three strings only string 1 ends up with the requested
> value.
>
> Use the 2 byte stride.
>
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


> ---
>  drivers/video/backlight/qcom-wled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 2281007bdd459..f452d328997ad 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -54,17 +54,17 @@
>  #define WLED3_SINK_REG_SYNC				0x47
>  #define  WLED3_SINK_REG_SYNC_CLEAR			0x00
>
>  #define WLED3_SINK_REG_CURR_SINK			0x4f
>  #define  WLED3_SINK_REG_CURR_SINK_MASK			GENMASK(7, 5)
>  #define  WLED3_SINK_REG_CURR_SINK_SHFT			5
>
>  /* WLED3 specific per-'string' registers below */
> -#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + n)
> +#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + (n * 0x2))

I saw the comment about (n).

I'd rather see that in the marcos... but since the new code matches the
existing macros it has my R-b with or without change.


Daniel.
