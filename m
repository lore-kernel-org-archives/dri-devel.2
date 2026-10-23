Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49194606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=mEgiAF0V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A554E10E60B;
	Fri, 23 Oct 2026 12:05:33 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E8F112AD9
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 12:05:27 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a1fe9efc0eso8706705e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 05:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1792757125; x=1793361925; darn=lists.freedesktop.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uSco1V1HeJRIohr0HU9Igo93pBA2b9NsqhyVUoLr4Hc=;
 b=mEgiAF0V4TN94GYlbB0Hxm0u2gYskNWAZE79V6mPaNj0BsXiT0fCJk3rIDZciX9orq
 sWUifvfssBZ80deUbkyc6V3JL7gSyDXuxynemCfUF5yMNxCqgu3MVMoU0cRqhoy2AeL9
 eKawBv2dDRkIfy2lkJiHIgrYrjNVDP7ai4Egk6lUGgxsTJ7+GfNMRi9m1ZMGy6bQs+hK
 aryLi6/Xn72DcerOHoOuvbdUlmiEf1cKYGIRu7DDvXQcvv4IZGr92+w11Zo4DQaOS8yi
 BMBcCONJq+m72C7fSz1PebCfxg3cXJjSxxyjMqzjSnbylutGfs6AGzM8XayRWKvBwZHq
 tNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792757125; x=1793361925;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uSco1V1HeJRIohr0HU9Igo93pBA2b9NsqhyVUoLr4Hc=;
 b=Wf5GNACD4qYZd5iS04KQE5JWHdh9ftPQsPbxw8tcXsUJSCOu4UcH3owmcZjf96pqOT
 DTJFQw0cRV2YFYS8s+gF30VdOWPOicb6n0BoK66FDuBc5ZYExd2WhEBYO18H6zZveJJf
 mVfe3j5ejvL1vAXyj8WC5dUcVpA+4KiitsVMdKPMJNpdbE82dh4O7iWULoB3WRvkbxJw
 zG2LE2fYS/Sb9IqTASYwKhSQH8CAUAAoirrT2rtD6OIQtWT/QcFXs63G0n+JN2BSALEQ
 GtR/lbLBJJZMz7UjwNgVmGLkPtHEyd106BwlF9/ojAmrx4AtHf+ttWfS9a35klrKiGqn
 1eag==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWZ1DVrSUysPo5x9bhdKOWsUhBvvQhdUw1fNAzRw3EKFCDkonSW1dq1JC2mq67pyax0Ac6cqbBvvk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLU6k+X0UJclFrmm4fDZCeREwwulhX7ixksOuHMTJOIxbb43I4A
 qQJ2hrDL9WGyEKJajckUNxRATAspJkrT27OOIjHFnGpRR92PkRS/Thrm8+wYM8oLJk8=
X-Gm-Gg: AYBFou39RVxFO7uvRTOPp9xxxXNoYr34gHjhHTJ75d9jlGRLiV+XsMHb2j94ONL81K1
 9bi/HG7Z1Dg3RqL9Wky+MlMuwf3ICu33LRveVr8z7MSOieu6GnLtEXc2ehUxWX+mmAO4yueS1Yo
 jCAp00uu6UB23FLx8LYT+1pXBikBr04qNeSMBxn6ef13fyTWB38n/UAlcqV99IJqEsqa9+7JSv+
 8focgWrdO2PfWhsvFz7I/52oTxMBc9OXl8TmC0nlq1gT8sSf/Xz0DB+HNISZ/WCP7OkBIacsLsC
 3gaN9lMcB7oaRPUomSYKeQ1QOKtLdDRuxXiMjcBdOVVRn7dCdxRt6YPtn5ww61G5wZLh3FTNVF9
 8pbgm9N7C/MJcDZDfr/qHABf6Qp7JVsCDOK/0hAHVVN8c18Z9ihSiQjPDCx8gb75a7rq2C9c++0
 267sq1hljAX3IK1RvHKo9a+qSIbWAIeFEV9sxZTw/JE3jvlnCn49HTPdcNBykAGK7bvteR36lqz
 t5A3GwsK5/ePX0V48sHN8R7zasecuUN5426FqXaTgn+N1Mu8b6TLM2OaA==
X-Received: by 2002:a05:600c:1c08:b0:4a2:16c0:f4f with SMTP id
 5b1f17b1804b1-4a216c010e4mr22298145e9.30.1792757124684; 
 Fri, 23 Oct 2026 05:05:24 -0700 (PDT)
Received: from localhost ([93.123.20.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21544dc5csm28563925e9.3.2026.10.23.05.05.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 05:05:23 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 17:35:06 +0530
Message-Id: <DMC7CT2C3AZ5.2SEL62SMKTXEQ@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "erebion" <erebion@erebion.eu>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] arm64: dts: qcom: sm6350-lena: Add
 qcom,rmtfs-mem node
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
 <20260926-pdx213-upstream-3-v2-2-b4612e3eb536@erebion.eu>
In-Reply-To: <20260926-pdx213-upstream-3-v2-2-b4612e3eb536@erebion.eu>
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

(re-posting my mail from Sep 28 because apparently I forgot Reply-all)

On Sat Sep 26, 2026 at 7:30 PM IST, erebion wrote:
> Adds the qcom,rmtfs-mem node required for the modem
>
> Signed-off-by: erebion <erebion@erebion.eu>
> ---
>  .../boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 17 +++++++++++=
++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 79aa2521aed40..0ef3e9e239786 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -4,6 +4,7 @@
>   */
>  /dts-v1/;
> =20
> +#include <dt-bindings/firmware/qcom,scm.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> @@ -54,6 +55,22 @@ touch_en_vreg: touch-en-regulator {
> =20
>  		vin-supply =3D <&pm6350_l6>;
>  	};
> +
> +	reserved-memory {

r (reserved-memory) < t (touch-en-regulator)

But it'd probably make more sense to actually rename touch-en-regulator
to regulator-touch-en (to keep any future fixed-regulator sorted
together as well), then the current sorting makes sense. Maybe add this
as a patch before this one?

With that fixed:

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> +		/*
> +		 * The rmtfs memory region in downstream is 'dynamically allocated'
> +		 * but given the same address every time. Hard code it as this address=
 is
> +		 * where the modem firmware expects it to be.
> +		 */
> +		rmtfs@fe901000 {
> +			compatible =3D "qcom,rmtfs-mem";
> +			reg =3D <0x0 0xfe901000 0x0 0x280000>;
> +			no-map;
> +
> +			qcom,client-id =3D <1>;
> +			qcom,vmid =3D <QCOM_SCM_VMID_MSS_MSA>;
> +		};
> +	};
>  };
> =20
>  &apps_rsc {


