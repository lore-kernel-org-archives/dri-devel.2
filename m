Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D06CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68C010F6F5;
	Tue, 13 Oct 2026 10:17:13 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B67010F6F5
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:17:08 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa377c61so3029673a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 03:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1791886626; x=1792491426; darn=lists.freedesktop.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q1nANBNsyQWXnn8HGzdSfGCDeYeCmohBuEkqclHHM04=;
 b=Mz56Lb66FIdSp4GfHqcJ02paXUhT4MA6Xkq9O6UJAY8B0eJx8OLOCwGVkKiyfiyv5P
 Nzu1BMJEJkQab62ZJX210ZtD7HTlwTJmkfl9ZPHKJFvpZRmVQAwTkKyn2Z5mne0KnGye
 fq22f55oSCrObS50V5JFTdIWMcpjkkmpBOvt+gYNbHLYbQQZ4dBiNYikLmgw7vWPGLxT
 Y9k6luBH1khDZ3LH8s0fRx37wk4x6VjQ2BvCgZA3DrWVy/3XpM5vsPASoGYFSlyj9B0e
 QKjS14/GWwQeIkMYOqym5CesCt8cDSIM192OLZMfhaZ6T/ngQTRGaloMAuZmiLzMHj++
 pH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791886626; x=1792491426;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q1nANBNsyQWXnn8HGzdSfGCDeYeCmohBuEkqclHHM04=;
 b=gmLZQOmMC4ZJ5CwbahfDwVqtftTmVtDswCIs4Fh1UqN2nsMZoyhp9TaBbS1w9WVVCx
 ly6c8+mWTuh685NXinWo0nMl7ig9ZswHabr+BOFg7nvZJOGabhStMWTk7AGO6DFgbGv+
 vqNz3TWVoDHrqaLlQxGGDay0ziBwZRsZAS9iCfejkqDZROonoH/QsTdtmknNTKK8JvZU
 JTgEUjZQypKdsrep00rdaFcsalRNEJdpdQOzUYoXytrw3hu4sPL5pxgw19TzFVeBpGJy
 Uq/1ILE4DMF7UyWqo4sJ2gJgSM1t84QLtAkKpIKJ8BGuUTGCJFNy/coIZnUF8qp266U1
 LugA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHUC1iIld0+rIwBxIxxX+aVljEIgIvMTzrs/Myf8nH2mV2WUr2TvRIfMqJuU5pmZZO5ULEd9Bf2XU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL67cTaYx+SnRo8bzdff7A8HQfm9A89sldcv+7r+KXXXEt6i0ul
 js5SiivXg4x+8C6w8TP+jgs9KzCyVmtm+G9RwGJoTjQmMLGeb75YUGP+YzcBye2wnFw=
X-Gm-Gg: AYBFou3fwjrVunyfc/kqBDrz2bqdYNCR8ucEba/dqZVPY8WHXBsom67z8kYSncDPeMa
 EECi4h1iR2bzZhuC2ue53lM3pUGCCSsxD9w1BM7UYGxBMSJ2umYFCvw4ogb2Vq/vQw0xHfVzEjB
 slMVsfGav3GcUTZZwSE5LvTKxVl8k2ThjxouN0lEnbnklgYVM4TtZo0wWELf4Mm0r8PlP3z+DtX
 Zvb8Yx9gTIctpAPrMWjMeJNZw9TWa24841WWSunhoGZGfwIm8xeMa7kjaDHYkZsFkRzOpqROC0r
 PHCXBuVbtUYb5vCOfmGGGQGK8B1IVDMgUc4eE4Tx2zWxcN032H95+u32rGDMk0UIHZ9evdOulE7
 VgNaBspuoV+dBTUipI9aPms+5xEG0Zq/PYEb88qyKIxsg8p7Tih3gbZF15p9WztJI0Sg1N3PuXP
 0dn8kVdN2bJksg1piG4pQK5ABScOYHu7xV4iYyxvDexP3jr3D8FlpwjKkxEWDQqUJJeTrc/9cuW
 l1yFGLzvOEBqtLvXMBP2t+WkVENgCdzQ5ra7sl/iV/9P/kXlf8Tbw==
X-Received: by 2002:a05:6402:254c:b0:6b1:b9df:6001 with SMTP id
 4fb4d7f45d1cf-6b1b9df64e8mr5421183a12.6.1791886626364; 
 Tue, 13 Oct 2026 03:17:06 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179e012a7sm6018180a12.36.2026.10.13.03.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 03:17:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 12:17:05 +0200
Message-Id: <DM3MSNLF42BV.1UV490PXB0C07@fairphone.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add Samsung Galaxy Book2 Go
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Douglas Anderson" <dianders@chromium.org>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, <cros-qcom-dts-watchers@chromium.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>, "Jasper
 Korten" <jja2000@gmail.com>, "Federico Amedeo Izzo" <federico@izzo.pro>,
 "Luca Weiss" <luca@lucaweiss.eu>, "Hans de Goede"
 <johannes.goede@oss.qualcomm.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
 <20261012-book2go-v1-3-7188e7ea7a15@fairphone.com>
 <fb634f17-de56-4f43-b139-3d040a35f019@oss.qualcomm.com>
In-Reply-To: <fb634f17-de56-4f43-b139-3d040a35f019@oss.qualcomm.com>
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

On Tue Oct 13, 2026 at 12:10 PM CEST, Konrad Dybcio wrote:
> On 10/12/26 8:11 PM, Luca Weiss wrote:
>> From: Jasper Korten <jja2000@gmail.com>
>
> [...]
>
>> Signed-off-by: Jasper Korten <jja2000@gmail.com>
>> Co-developed-by: Federico Amedeo Izzo <federico@izzo.pro>
>> Signed-off-by: Federico Amedeo Izzo <federico@izzo.pro>
>> Co-developed-by: Luca Weiss <luca@lucaweiss.eu>
>> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>
> Good to see the Lucas are in agreement ;)

:)

>
> [...]
>
>> +&pm8350c_gpios {
>> +	pmic_lcd_bl_en: pmic-lcd-bl-en-state {
>> +		pins =3D "gpio7";
>> +		function =3D "normal";
>> +		bias-disable;
>> +		qcom,drive-strength =3D <PMIC_GPIO_STRENGTH_LOW>;
>> +		output-low;
>> +		power-source =3D <0>;
>> +	};
>> +
>> +	pmic_lcd_bl_pwm: pmic-lcd-bl-pwm-state {
>> +		pins =3D "gpio8";
>> +		function =3D "func1";
>> +		bias-disable;
>> +		qcom,drive-strength =3D <PMIC_GPIO_STRENGTH_LOW>;
>> +		output-low;
>> +		power-source =3D <0>;
>> +	};
>
> Drop the output-low, the consumers already take care of the state

For both enable and pwm?

>
> [...]
>
>> +&uart7 {
>> +	/delete-property/interrupts;
>
> Let's add a space after the '/'

Will do

>
>> +	interrupts-extended =3D <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
>> +			      <&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
>> +
>> +	pinctrl-1 =3D <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>, <&qup_ua=
rt7_sleep_tx>, <&qup_uart7_sleep_rx>;
>
> And let's wrap this line

Sure

>
> [...]
>
>> +&usb_1 {
>> +	dr_mode =3D "host";
>
> Does OTG not "just work"?

Is this a feature one would want on a laptop? On a phone for sure, but I
don't quite see the use case for the laptop to be a peripheral? But I
didn't try it, the USB basic setup was done by Jasper

>
> I'm assuming there's no pmic-glink on this device?

I'm not quite sure yet how the USB stuff works. For sure from
observation, USB-C only works when stuff was plugged-in at boot time
(UEFI?), and charger also only supplies any power (but not actually
charging) when plugged in at boot time.

Regards
Luca

>
> Konrad


