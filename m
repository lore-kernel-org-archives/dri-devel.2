Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C162606A333
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=DU8tECVu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7FAD10F69D;
	Tue, 17 Nov 2026 12:11:19 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9E110F695
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:11:13 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c50dd1e2f11so308474466b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1794917472; x=1795522272; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cWtgHE8VVeVY+BSW9SOQbCd+UmjyRbtL0IM9idnQATQ=;
 b=DU8tECVuR6WtHTCZolfYxS96JykgjSsd3zv0se7h4hIRHPwxenlNmKGfH2csKJhX5u
 iXo3GQrThGQXsmga8x2dCoVZx1vLR0QDbjAm2M6hVH8xld/TrTAoZTisIWhr31r+uXsl
 PK94hzAssx6AHW4XDjzDUwHQh1zTdp18EPwuMp+u7LCwdFafvrXYudDYeEd0xzdUlmzX
 5OxWpY2LH1iUxsRFmNbVd+rwx6O9mxBrFUXZP/rVHR0aFj5Y1RVbxeybhQq4rN6K152J
 lZZaveoN9E07fmOED69p1Fbxm5V4yqaC87k0lYkJa9gDf19KiJwzExiZhjFD4izpkZ2+
 UwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794917472; x=1795522272;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cWtgHE8VVeVY+BSW9SOQbCd+UmjyRbtL0IM9idnQATQ=;
 b=Zmwcm4CikClLMGNxKsPtx+Z0k6eKsxBVO/zdtbamJRDm0Cmhrw6JxcbMZpvv+TkILj
 cwr1gBpl7ra0MN8LRW8eoCEKpGJQbF9OC4wUGI54BQ8xBumC8sEFlximcehSVi2641GB
 B8nBQwr7p0afhdnO1phRbhjtcyy+Vaurt2XzP5SDPY22zJK4NQMvFJd4fQExkxr/WBkP
 l3tK5cKNG1hOMU44GNTbkgbcTW8TePKamoP9YDaJNduxZmXZbotKHQ0t0V+BE1CwucVX
 u1Ex2o7PvUYTk+Zy+0X8d39BLzkOGmIk5/02AcDm3MlKC/SgDOV19hu9KI9hg9Ac1PG4
 fJxg==
X-Forwarded-Encrypted: i=1;
 AL+hErGaxIpjXUIrRSsWJQ2GmXX/ktds5mFfm3LO6XifMVykIk4EO73XVpz80wKmM6lC+1b5Zu1YRb9OEIY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9zx55afh/ptm27doyqoOP/vPI0Cfxo7RgDPriGku+zCanRHFG8
 KJRGuX63i/YIqhyMqRDbIjfotIGggwaiLiBLnw3Vs4+6YAQNT0+hMlu7U2Ag8Vj6feQ=
X-Gm-Gg: AYBFou262YCS/Gw213FtrI15X2UZA3WSm9XuTas9ZYyznoEmpdCCdmoqg5lFxIrUQ6l
 2Zu6RstgRhA8bQRYe94v0+QaDr30c6n9mlx4UlmriVUEJ9VTOBJXYBGcRWlVHWqidXW9FahMOZN
 gSC1E+wzk6tVZ/qKRUJAssPKStmutv9iQnKJfd6wXAx24TV1NV53POXPDbBHxLzTVhyeSlJ2KMO
 9IdlaOpB/Kr5uGHky27eVq1SrhIeLbj9QleO13dr2IVLsbuAG4JGp7m+W6COqCZZbeiab89zmAh
 rWDX1d317Hz0mzNs/nrQz2REnqHj67fSH1qXrYpOJBNNb+WqSFI63cuyNKeE/qNOLoCUyTau0Gy
 aRy3RwzXUPbpTMhN6b46XiaKdHMpp3HF9aP+pBUwwrbVDCDqakUE1Bt3FADO5VhQtkgkIb+nZrG
 ROhLW9BIonnVAJPv1ZQtM81XWHf9MXaNAmGt8K6BIcMvRKFcL1s5E5zJ0GfpNiU6XfeyYOXvmq8
 WITlZKw63OgPCFyLT05sF44ELBOghB1zg/wlEgc7aGAtkVworNkkw1P5iQiQhNx2jC9OizmJERi
 mlFj5yOKeMGSK0P4oFfwTreY9OMaiqp2j3pT9fMeo/PgYble4zryCk3Wxg90sYMHuyvibQQWs2h
 oyKiUw90BJV/xvt+iPS8=
X-Received: by 2002:a17:907:1b06:b0:c48:1977:e1c3 with SMTP id
 a640c23a62f3a-c509633f436mr1276035066b.21.1794917471802; 
 Tue, 17 Nov 2026 04:11:11 -0800 (PST)
Received: from localhost (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095a5c00fsm532002066b.3.2026.11.17.04.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 04:11:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 13:11:10 +0100
Message-Id: <DMXH52GLPXUT.236KX5W7LSRY7@fairphone.com>
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <phone-devel@vger.kernel.org>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 12/12] arm64: dts: qcom: sm6350-lena: enable
 remaining i2c busses
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "erebion" <erebion@erebion.eu>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-12-7318a19806eb@erebion.eu>
In-Reply-To: <20261116-pdx213-upstream-3-v5-12-7318a19806eb@erebion.eu>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 16, 2026 at 11:50 PM CET, erebion wrote:
> Enable all i2c busses where something is connected on this phone. Add
> comments as placeholders for which components are still missing.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: erebion <erebion@erebion.eu>
> ---
>  .../boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts   | 18 ++++++++++++=
++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index b19e76b3c1a75..08647584af0ce 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -438,6 +438,13 @@ &gpi_dma1 {
>  	status =3D "okay";
>  };
> =20
> +&i2c0 {
> +	clock-frequency =3D <400000>;
> +	status =3D "okay";

If you resend, add a newline before 'status', also with i2c10

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> +
> +	/* PN553 NFC @ 28 */
> +};
> +
>  &i2c8 {
>  	clock-frequency =3D <400000>;
>  	status =3D "okay";
> @@ -455,6 +462,17 @@ touchscreen@48 {
>  	};
>  };
> =20
> +&i2c10 {
> +	clock-frequency =3D <400000>;
> +	status =3D "okay";
> +
> +	/* PM8008 PMIC @ 8 and 9 */
> +	/* SMB1395 PMIC @ 34 and 35 */
> +	/* AW882xx amplifier @ 34 */
> +	/* Foursemi FS16xx amplifier @ 35 */
> +	/* FSA4480 Analog Audio Switch @ 42 */
> +};
> +
>  &ipa {
>  	firmware-name =3D "qcom/sm6350/Sony/lena/ipa_fws.mbn";
> =20


