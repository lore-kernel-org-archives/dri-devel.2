Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4F8C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E76010F92F;
	Fri, 25 Sep 2026 07:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MT/MIoiU";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F50910F22E
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:48:48 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6356f6bso1174667f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790203727; x=1790808527; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0bBcYE+SQRKaZ3abUhRDaAJqY0dLEhd7Hp6zqwKtzbA=;
 b=MT/MIoiUM4MaIWc7Fv//SAGxDvhuryMjI6oSwqlEIA23xsy6gVQ67G1V/3PN6CeZTV
 gR0YD3yk3d3W05edXFfwanmyTl9BMkcswWlxB5gjHcOJWNLlhaArxmRo8JSNaUaqc8ll
 YXtp538OGXNlTtsM4zsFKuZd/b7+OK4EV0zchNnfBr/zZBR6leQTklML+eatgeqY67rQ
 GH0vBXwA33GJ5XjXtpME/avo2dWmvp2Rd3bzslCLXb86lZMBJ5M2l/yUhsUElJ+GytaN
 j0tuKuaMzhRK/79pbYDSZEBLea5g1MzXluWvxTs7tde+7RUE5y4W3Yia7DPYvcvP1Shu
 /irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790203727; x=1790808527;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0bBcYE+SQRKaZ3abUhRDaAJqY0dLEhd7Hp6zqwKtzbA=;
 b=PZXSLcXskaAym3ahtDoJQQvWgZ2z7awXu16jk+SYjMA4V4tqYr2Ymbhd5j0rYlLVH9
 xWlkdAqI3blmR/iH9BRI5r9iRO3mQnCl100gnwNKH1h/8bMkfEck/ivo6qM2fyFs8auM
 lUF6dP9jBD79v1i78x2vQ4/ksmIvghrtG9WfGHFJKuKw84cIjOGhrLrY6iwNj647jdJU
 ziejPmeCDJOVKwkSxua7DV9cS6BRuplH8Qxij2dgqUraf1fM4kqnlQLhwdkAl2jIIJL1
 ieTSrYrz7QiHpdjCS62wN9oSPXvQsj+MuvKpKhOIKByyTIFoYJzLLH4hiF2GC9KTqQq4
 lgtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBweQBTZWXVHifnbm3iyAHi7ia7aZigBcfqfXG4jlAzIVRi1NQr8krgXXqTbQMu4xVSJjorTMLwHhGo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lEorFb5XwAMWQANmht8TjNyBXy9HhVogRef9+vXooIYBFN174k
 jSwAGumjSZANxr6j+Naf09GiQ29K0mQE+g9G/AxHJJa9L1oR6sQDTOzR
X-Gm-Gg: AYBFou0PEk9HF3P7l+PyfflGD6HwxmvKt1nQ59teikxPq0yjkKpvGgkuRXk9nM0Uy0L
 0Ez133OkQy0ckTSGE1U9hy38LCPJPQn2GbgzkE6EtjYQk4hQt7BUviUjalZ5Xlxpm06W9QqCCV2
 nxtaP7QDYcMXZsLlx5GkWHKAlOvtcjGCCdwxeerAz2QEPIhrGUnJUvC69pbqZ5LzQuGC/ZNY/x2
 Wmlmmfh33UUqxt3K+/hrIPgcKVfZfqeFT2iyVZi8NgBlUERW9hDkqoC5Fl2evrUx6mxKXQNrLUv
 o9XHdih4XMW7tMInwVP/vhsim7B5jZscJNRYYagZlfuWtHNQsEY95uSey+npWlputRl/0Jrc9Pz
 Y2X+yKpbwL5e1jPVEIJ1DxdHxdrH9/7RvR5yNyU5f/KdVYLpeQ3YnF5DRIMEVMRA4CCoiiHLWkb
 Hyvh5dx8ZI1FmeKmefa/G5Rh4+7n4qq8f9yUihbNdvWVABFbwIsp7XHik4rtQXpyP4L9MlEwdzz
 qM8XFTI4eezGnsEXQA49TIGQ0cS31Or+4o=
X-Received: by 2002:a5d:6f1c:0:b0:487:27f9:83b with SMTP id
 ffacd0b85a97d-48871718605mr854372f8f.48.1790203726768; 
 Wed, 23 Sep 2026 15:48:46 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877a2a5sm10789083f8f.26.2026.09.23.15.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:48:46 -0700 (PDT)
Date: Thu, 24 Sep 2026 00:48:43 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: devnull+david.ixit.cz@kernel.org
Cc: abelvesa@kernel.org, airlied@gmail.com, andersson@kernel.org,
 conor+dt@kernel.org, david@ixit.cz, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dsankouski@gmail.com,
 jesszhan0024@gmail.com, konradybcio@kernel.org, krzk+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, phone-devel@vger.kernel.org,
 robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH 09/11] arm64: dts: qcom: sdm845-samsung-starqltechn: Update
Message-ID: <20260923224843.GA185053@pevik>
References: <20260920-crosshatch-panel-v1-9-de6e9512da96@ixit.cz>
 <20260923222521.188197-1-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923222521.188197-1-petr.vorel@gmail.com>
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

...
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> > @@ -262,23 +262,23 @@ &mdss {
> >  	status = "okay";
> >  };

> >  &mdss_dsi0 {
> >  	vdda-supply = <&vreg_l26a_1p2>;
> >  	status = "okay";

> >  	panel@0 {
> > -		compatible = "samsung,s6e3ha8";
> > +		compatible = "samsung,s6e3ha8-amb577px01";

> I guess that keeping the original "samsung,s6e3ha8" would cause that ABI break ABI, right?

> compatible = "samsung,s6e3ha8-amb577px01", "samsung,s6e3ha8";

OK, I now see the deprecation in 4th patch.

{ .compatible = "samsung,s6e3ha8" }, /* deprecated */

Kind regards,
Petr

> Anyway, LGTM.
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

> Kind regards,
> Petr
