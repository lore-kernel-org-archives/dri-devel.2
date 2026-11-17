Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC26606A890
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=Z1PsRQsV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1948710E5ED;
	Tue, 17 Nov 2026 12:07:08 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15A910E5ED
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:07:01 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c4697404c2bso614355666b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1794917220; x=1795522020; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aDpnAdxCSfd2EKAnSTqMP2/M8c/xtUmhy65PUV7fU9E=;
 b=Z1PsRQsVQ6ALV261DRXSlFJK9UsKOYu7hTNOSM1UtfuPBZnTqFP2QSgPzsTBvrMaD0
 O337Iu44aXnu9qmSWCnmmlmoHKcDX6fERZTcZZn4jo0fHypR/MUrIizBJEgjshstWzCs
 TwS2S3Aam1IdSE7lADXCCCa1dQNyrcgXUDfJIB1MNffwtP+i2T3Aq5BINo+WH0KQ4fzj
 +kAEzWTsLxYzyV0AOcXFyTRbiW7JDu3eairfKO1LFi0j0mXuzxv/iCVco/6QW72tJSp2
 0enLnmmr/fZD9WxDYFhIYnAlCAjoxz288VL6ioitxvYVnZYGsX/hn9WF9I+n1Y20Nchh
 3amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794917220; x=1795522020;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aDpnAdxCSfd2EKAnSTqMP2/M8c/xtUmhy65PUV7fU9E=;
 b=S5W8bvXmg4w36Pj0UORD5OmehAx3wpe0bCG7QLXLWksC4QLXbVip/M6LAmJL2E/sta
 UEw44JsRO5aQMbGgEDlM0U3jR6FFqpbdCgjPw1CiM6prfTRhnLpPsz4tgoOlkv9Jqf6u
 UpY4mOpIKIIBhu/9hBm3iSG5RUrU67XxC/iz3yxMbmL8bP3+pwoyhC04cytaoLe84h8p
 ii5lbmDN28pLk3tLKN8sbO+yYmWRF/l6+n3jVOevJhoxkEq3Wlc5fqrqcjLgemsAL4HZ
 NC16xjrWEKAYGf3KVD/s2FUkJGrjEXqq26QxsQDqzOKQzXsjceLN6QM4hj6DpVFZy4eI
 zPmg==
X-Forwarded-Encrypted: i=1;
 AL+hErHnRupgkQNF+7ZwSKhDoe17Eudf26gH1sXK4RU2BrtJoOXo2GmoRXkF7nNLv1yUO9Jeu+aXXQBau7M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/lkCR0s6S7JIcV5jBRGCSHm9CxqSgYk6by8ut6HLo9DTE1hJPo
 Co7UuTgptJ04ORefgTcslEJQVmYPfXzUyVewPmcTSSoCjteb4f+B/Bcu58bOXPNds+s=
X-Gm-Gg: AYBFou2o5wtWN6XFRGC3dfeO7orRriQND94RzFv5jMnP8Wv/uMXvL84EkIV+sTLxZsK
 SIO6ob0SH+SRFlMLG1iR4MVJkO0IOz6D/qz40qORRh9sNd0ZR1V70U32jqvGBMevJ5UDtOiK9xH
 ewx7qfUkpfVJunoKARpr+UfWPXW2cNUGnFOOWmR7X7ZC0MZ6rmo1esyC4FYUsoqoVdVyoZKPjSa
 5X/Ge+gVS70Yyw5xkq+0LzxLKz0swgWpTgmxpN6/p8QvCfATupg35lVkkMOvvueWxLHeX7NkWaa
 9mlHxezVM8QTIW7pHs7S0WfnoElUdPwSXoMkEtLT2fKQM0AF2xrPmax7UXKweCCWCTh9gLGUDZU
 DeTWqK3YBc/FaUWFSXQOKSr2RHiOaZbBHLfo6fKJXtdDWV5brcN3k6PwdgIrrpREt9pj1NW8bXL
 EdNj75kwiPadlmosbal6FwEAyg104jRkd0j4tapsMNntqfI6vxF40HT+8cGnnGekhHqG9Iw68xY
 3Wir3Yp20DEiI1WLbnr6xkT1LahAyqhSLreo+Ui4Eg8TkXxL7FIOPhqC6XItiHWBsfhE4odHY6c
 NErO+L3hjDR3wyTGt0xzu4Ibrdi3pCz1M7Kn2d12iUwKTHtWP9LralPNlHPXn0hYopTAe6aNOg=
 =
X-Received: by 2002:a17:907:6d02:b0:c4d:4d5b:4bd6 with SMTP id
 a640c23a62f3a-c509654df6emr1125503166b.41.1794917220010; 
 Tue, 17 Nov 2026 04:07:00 -0800 (PST)
Received: from localhost (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b51bcbsm522082066b.44.2026.11.17.04.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 04:06:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 13:06:58 +0100
Message-Id: <DMXH1UYFI74N.FT441QG9ND7@fairphone.com>
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <phone-devel@vger.kernel.org>
Subject: Re: [PATCH v5 09/12] arm64: dts: qcom: sm6350-lena: Add PM7250B
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
 <20261116-pdx213-upstream-3-v5-9-7318a19806eb@erebion.eu>
In-Reply-To: <20261116-pdx213-upstream-3-v5-9-7318a19806eb@erebion.eu>
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
> Configure the thermals for the chg-skin-thermal and conn-therm thermistor=
s connected to

This line is a bit long. If you re-send, please wrap it.

> PM7250B.
>
> The trip points can really only be considered as placeholders, more
> configuration with cooling etc. can be added later.

Could also be squashed into "Enable PM7250B" but also fine as a separate
patch imo.

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> Signed-off-by: erebion <erebion@erebion.eu>
> ---
>  .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 26 ++++++++++++++++=
++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 50a235d6fb6df..0bb714eed13f4 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -80,6 +80,32 @@ memory@fe901000 {
>  			qcom,vmid =3D <QCOM_SCM_VMID_MSS_MSA>;
>  		};
>  	};
> +
> +	thermal-zones {
> +		chg-skin-thermal {
> +			thermal-sensors =3D <&pm7250b_adc_tm 0>;
> +
> +			trips {
> +				active-config0 {
> +					temperature =3D <125000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};
> +			};
> +		};
> +
> +		conn-thermal {
> +			thermal-sensors =3D <&pm7250b_adc_tm 1>;
> +
> +			trips {
> +				active-config0 {
> +					temperature =3D <125000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};
> +			};
> +		};
> +	};
>  };
> =20
>  &adsp {


