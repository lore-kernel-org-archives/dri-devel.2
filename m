Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C285606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=boBupTR+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9361E10F685;
	Tue, 17 Nov 2026 12:08:09 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13E210F685
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:08:03 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c50604721c8so725541766b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1794917282; x=1795522082; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kPzdzQ6tHDCIxM8wFKMRfpcZWRkcCcNtEPZkCPlC0Rs=;
 b=boBupTR+qnsMqzlj1iOODSWYD5ZbKSjuIZxg/4tzJ5PgyAuRxhLPd7+NNn7cbM0wd0
 71yVt1uLQS1wsuUvkWaO6DqV8oZ6CSxa8tFLcdyWVJ9G0xsGanjjzn95EqauzhP/TUzE
 MW3YvDBKTmL9USpBO4hIDvMYg6s9PoIW5wDZ07QnLaiyf4iOpVHZgXuMzihR/dbNsIgr
 NPMet+RBevO+p3yYEf/LyiBHqE+Upk3t5oXNv1MrsAB5LvTJnqbkegAVyz/NCLzpLJWd
 QEH5Hv1M+/qzOjXPmWWOOoCHD3lu8WO0lOdw6htgB8QxK/JBU1u6ee2yz92thbG+IV1u
 z+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794917282; x=1795522082;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kPzdzQ6tHDCIxM8wFKMRfpcZWRkcCcNtEPZkCPlC0Rs=;
 b=lRHAOav1bZ5fqwwslVkYdV3YGDn4L4kBvaKJ40y1oFcufDixCpmWTOUB/Wt3XKbZwW
 ez2x2pseOuKFV/0cpDR/rLd2JaZGJNJiNjBZbPYH9fPBhHxA/k5saz+lwOxFvsaeK58j
 mp38e1zKNrHaO0fX/6dqGyDYt27aUAEEY9VYOqsrme9DLR9aOk+zkM+B934Olms93F+m
 ItrHP8Gqm4gjW7uI4cxRM6dM3IHIUux8WR58gQpsX2vx/fOFfktNj7XjOw0D9RIKX5YD
 Cd75mzCkzFln6eO1T3yOycUrv9HZe7C3T/z0ph0bd/TI6e1QvDv4F5FTihFxiDg0nP4+
 2pMA==
X-Forwarded-Encrypted: i=1;
 AL+hErFHM/UTvxxd4+XxIGFL/rRSTcoqs9sC42/2gwRdssfs7Khb6XNx/kK6x07oTBaoMf6ky791ki6Fcwk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z87ufsmnycdJJeiC7zntp1VAlimvQj18+gT96GV+TD6cpPT3iTp
 SQLyMpsA1Zfbj3dTh43VPvup7LLWQLzLlG/ijboT5zwuuIS49Mj1BsRze/aR+UX/xAg=
X-Gm-Gg: AYBFou2ZD/opjFl5s8UDlmt9TOwG6fuOMfEqBQ0bWc7yKJCtahxNfCj+A55Qd3o/9mi
 jsfP4GTlK7m4M9VLqqAo7vl2a3kEhKD3yUIXLRBUz0XrYl422Pco+dOzxFmAmhAtaZuPz779jnB
 PwyTg3aiiB1DfR+8wuOioqhiFRGGBftGz7LaoAU23jcthBJLURSuBVJ70bVxyD2qgeEeedr2dkM
 VvNchatDImfRs25QluOk9FY922oqijLOMXcpCBLcEGxzV0erCJALtBtbHy7hB2UAXGFK8sjoirg
 sVZ0QYbynqD4NnKvwpqeGHArw/hzt/7KZkzlK4KvMQFWUx3FbF3C6bo9X3kozf3F2ZqBZjSwDAj
 qnpf86RMSH6diYxYheGlYKEHHlDay3u1ESv/tD2LZA/UZGDKZvJ5zq75/+fFMeaZWNTa0RQolBB
 nq2tgrZdt7wyM1UBxTCssdodYBQmTcwyfwhEFNQSWvYv6JoseBPSCyOnF1rvLZBk3a4VadFJfvK
 UFSiWB8NxekFFxYnap8eq0KFrMSkDNlgGtCR3jhzyUAVqQObnl5BbC/TG6ZnnGAE55XaQcv/2or
 m7b2kESafeq3/b6VtolwurpeA8Kwb9CBvsMshZUZWQlWdVYGSSvRTDUA3w1udnzMbHmPXDHolg=
 =
X-Received: by 2002:a17:906:1f4a:b0:c50:aa10:d898 with SMTP id
 a640c23a62f3a-c50aa10db4bmr727613766b.26.1794917282269; 
 Tue, 17 Nov 2026 04:08:02 -0800 (PST)
Received: from localhost (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b8650fsm525227166b.77.2026.11.17.04.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 04:08:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 13:08:01 +0100
Message-Id: <DMXH2NN4W05P.20N2ROUFAX0WZ@fairphone.com>
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <phone-devel@vger.kernel.org>
Subject: Re: [PATCH v5 10/12] arm64: dts: qcom: sm6350-lena: Add PMK8350
 thermals
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
 <20261116-pdx213-upstream-3-v5-10-7318a19806eb@erebion.eu>
In-Reply-To: <20261116-pdx213-upstream-3-v5-10-7318a19806eb@erebion.eu>
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
> Configure the thermals for the xo-thermal thermistor connected to
> PMK8350.
>
> The trip points can really only be considered as placeholders, more
> configuration with cooling etc. can be added later.

Same as pm7250b thermal patch, could be squashed into "Enable PMK8350"

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> Signed-off-by: erebion <erebion@erebion.eu>
> ---
>  arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts | 12 +++++++=
+++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 0bb714eed13f4..b86fe11fd5296 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -105,6 +105,18 @@ active-config0 {
>  				};
>  			};
>  		};
> +
> +		xo-thermal {
> +			thermal-sensors =3D <&pmk8350_adc_tm 0>;
> +
> +			trips {
> +				active-config0 {
> +					temperature =3D <125000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};
> +			};
> +		};
>  	};
>  };
> =20


