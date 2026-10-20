Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DA5606A322
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=Zrk8lquu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D94210F778;
	Tue, 20 Oct 2026 19:26:50 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A00D10F778
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 19:26:43 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a1cef0439aso39372185e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1792524402; x=1793129202; darn=lists.freedesktop.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+cqAn1cvZfqce28oUYl/gZogIs+MYV7l073QLWo7Q88=;
 b=Zrk8lquunXf5KJhncIhDpxtnw6UnsxH4+23kq3z0Gsgv16Od6q/0Vn3lWs1vHgFHEI
 M1xqFHjtlOzIl9f4VGPo72ixiTFsFkGDVW9ZO/VZmHrxZdDdS9o/GGAVVQ26H8ha660u
 2yaWuky9wM4Oaz3FkA/SaYxrmc9QZkkcJLqM3EmwuhZHWE1Mp6qoyFvKMDEx4Hnv0gSI
 awN/MdPUdYkHfMs5L/NZKXvtefVLU6z/KDC0w5jxE0S49UwOp9IKROxLWp7TdZbFzw+I
 s9eGTK8+2nCCu4GWsIpUpghajBfvzw753NVN3tonQi5oCU6I3R1LaJ/Evo+yB6W9pSQI
 s0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792524402; x=1793129202;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+cqAn1cvZfqce28oUYl/gZogIs+MYV7l073QLWo7Q88=;
 b=LvjPLheC/1zJWNHjdjaa+y/jVFtF6BUIkTq/NMNbccof6yULUwEQcm30JcumcjVNbR
 K8EOvWs6DbhW1xe+hmjnPVqCxRAhRhtGpFyCVTgQuYgyewI+Zha68T1Hw4feSmCFUcCN
 IjUJx9JKe7WQ8tN8wrIQY6MvJe6J+XUHk+msh05vcDBn7xEQ9fkRMP3Y2PispUs1bQCt
 llPaMmZWg8GoxLgLNH1brm5rMsLIXJNGDuK0uu+/NLpzQnKhWMYQbayiiS99jBLJYlTz
 EBa/4KqTLdt76ekoYsnskUCll4MDfbXndhfR57A8tD/xeKs54GI6ubq4Nlw+5LhbUlcK
 J56w==
X-Forwarded-Encrypted: i=1;
 AKwUvByblMrw5Qga1a04TFGumr6ukOBtU3/gEE/CstvAituRmr5spAodBkHF8YHgFGP0QFC3fFntO6cT7ug=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL3Jrlwjyj1yIzzDeTMWUbeqxzWJzlI+fpx6zjp5XO+potXNe90
 vu0/OzrsFdKGcJkAZXRFlHGw4rXEFanlleMzU/tP7oAXVkBywcDPY7yzgy7AVLV6bX4=
X-Gm-Gg: AYBFou1ga1COkz83w1B69CvqBnbKL5Rlq+pRWKgx8ANqyXONRqd+x1Mq+G4oKo4FO+A
 dpNcZ/pXKNb+6ekh5IB8x7Alx/XKSeSvmbdrErV+KL+HjIZb32R0WLkvHj3ZQ6qhEQnaQ0qG3TP
 n+/gvXUspLbLmS2+9c1NbQ/Qq6TXnbuwMYtLbAGy2Ja7Mv5Cb6bN/KZ89q7p66KlC0LhmdvKYJ4
 GbRJgsU295GnAAAp9+27tDyw3jk1RGgf3Q4lXiINnERyhSGdTYtMPzNYr/Kec6VF6Ho37m1gW/M
 CXU1FA7ghikfsdEwuwJysoSgn4dNQRB+aK2Nn7bEJIRg0IVAs5s4MEGizrI2jo30XYi8LYtKwsp
 6ZBkedFMbmnVwfEBthtK2+vfN6QRojoE+YqVuSIn/WHJGej+RQHRoL0Ezd8eJdH4IxnqXIsgaEQ
 R95bqUEdhJIz8ThOV6tdGz6+wGhBvEbCbumgB0+JmBCzEJKQjr4DFfsxgwyTqQhBPzqF4l8Z3+w
 4EFYicDkl2GoLULhQhdrQ==
X-Received: by 2002:a05:600c:c119:b0:4a1:dbdc:b2f1 with SMTP id
 5b1f17b1804b1-4a1dbdcb405mr180375035e9.14.1792524401827; 
 Tue, 20 Oct 2026 12:26:41 -0700 (PDT)
Received: from localhost ([103.239.146.42]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903a275026sm846135c88.5.2026.10.20.12.26.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:26:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:56:30 +0530
Message-Id: <DM9WV4TQ3JAM.2KC03GKSF297S@fairphone.com>
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
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add Samsung Galaxy Book2 Go
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
 <20261012-book2go-v1-3-7188e7ea7a15@fairphone.com>
 <fb634f17-de56-4f43-b139-3d040a35f019@oss.qualcomm.com>
 <DM3MSNLF42BV.1UV490PXB0C07@fairphone.com>
 <720ed230-4284-49c6-9332-e29f23765944@oss.qualcomm.com>
In-Reply-To: <720ed230-4284-49c6-9332-e29f23765944@oss.qualcomm.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 20, 2026 at 1:03 PM IST, Konrad Dybcio wrote:
> On 10/13/26 12:17 PM, Luca Weiss wrote:
>> On Tue Oct 13, 2026 at 12:10 PM CEST, Konrad Dybcio wrote:
>>> On 10/12/26 8:11 PM, Luca Weiss wrote:
>>>> From: Jasper Korten <jja2000@gmail.com>
>
> [...]
>
>>> Drop the output-low, the consumers already take care of the state
>>=20
>> For both enable and pwm?
>
> Yeah

That seems to work totally fine. Will include those changes in v2 then.

Regards
Luca

>
> Konrad


