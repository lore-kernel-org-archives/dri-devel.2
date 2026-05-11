Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A58CD37B5
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 07:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B25E10E13F;
	Mon, 11 May 2026 07:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bwwDwwZk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MhyWYty3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3FA10E13F
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:56:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B4GXDx017877
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Edmbg0v8IiJzMS7+pZj6+O12JMZo1DqojeVoLzn6d+0=; b=bwwDwwZkN19D+dg7
 Qik8/CgVd7cIyqU0UOPCzEc/Eu29+h/67A/pWrjZNsY8tayPTDjBCAUO7KEo7a/k
 D5LeIwhJk88/xoNslggq/5W09RT/ugioF4GNw32Jj4ZVDRbB6FZ5w/ZzqVMIZg0d
 hB/Q6kGrgbozOdQbqz1BzwGP5i98MoiVqQQRGMuF0UtAQJMM9REHLjJehnbMwXOt
 +ElcxCGGfJwGOWrBsqw4xYUdnh62Gq9uCV8W+JMLlNyHA4h9sjpgYaDstq2K+yA2
 DPVLWI6ufoTiyYte7XssBqedVBxKJxoLvAxH1TRl7BqJ4dBTUKFXL4iZqR5bAUIZ
 qL4qvA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xfrpms-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:56:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-514ae0edeb6so31797641cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 00:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778486201; x=1779091001;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Edmbg0v8IiJzMS7+pZj6+O12JMZo1DqojeVoLzn6d+0=;
 b=MhyWYty3JZXcFtYTGQndLAknsyDZJWdhARczb+xj5bA7Pe4jqpXrosi2ku+7obCLiM
 clqJVyF3wzdKRZDcDJSHsxVZZCdVMCkp05v58gjaIQin9YAK5XR2nR5L+748HYN4fZiH
 QOsWNdC/ZjTCBk9vbC0yPlL2lXHhn+LQX9UGPJs2MkhdgGZQxXeb4HndwkI0wcCMh13d
 gyh3CGmGL8jVZdj4uWvEwgX9cM/vuWeo7+4zLFoWFfypBWsqjOAEd3uFpZxHH8F3N6/J
 soZ755TruxIqemHO8QXfIKZX4SWHReClnpVSch0nRFTS4ZvrxXK3CtcX4SaXDlTTNkuW
 rkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778486201; x=1779091001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Edmbg0v8IiJzMS7+pZj6+O12JMZo1DqojeVoLzn6d+0=;
 b=AoXpLRBj0AWPb3NDkINCVybCbPG6F4Kakce/zxmy3/jz1fCbK95joAzVzLTXrE7Oti
 kgiDcSPLGr+m79gM8QQEsnZjtZn3K7jQhlHHq98+x0D1HD6rAI0sQ52yZ6W5n1Bz7n8h
 9JCn2PWjndOuzeGjyXtrFOcVSAC880/LCN1z1hapX4C4Dta68uXd9DOBx+9ciqqjiMXL
 jih2FP+frrjBNt9lEg6ktNGbjuthBhwWsppzv0Wmvw6zKgf889qPKKL0lh8h1jYpTqkZ
 uSjz95jzOirVhuCSBYBaUo9GgL34nsHcVvNhDNlTRTIOOoe6svWAUOgxPDRQwvBj4GAO
 CTgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BUfpO0xzRoz7C06gsw0nxLXZYL2bzO7gajhQdDCNzJaDfEsB/bTLhG6e+G42WYQpp9KUZR20qRpU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVxedqPlF6g3t97z+dUiKituVI1jrskXjdMEWGdDMmWS/nJhs/
 wvf2OPYJalryy5dXA+f5TnBN7fxqQFuX28OckJJMZDSkZzHSQGx1l77eSftSsFHPBmB99kDfK4/
 XUc6iFpUa+UnlRCnuMNdl7stlQOucChBaYlkgr0vIop+w4aQXuLdthlSezRquth62Ba52VJk=
X-Gm-Gg: Acq92OE17me1K0UIVLivB8JvI/RBBYlj0H2ZHsUoNqauNhW+6DlqawaGsHiK+CMlS5T
 EAmI7iEY31b8NjGh4bptsQGgsP+MAssGHgkmEeIHKA5xX97txRPI7LggG3zg0b8qFcLNgQUCNGr
 h5Zs+mk2ywwK3An8wToiQ9ldjBbxwraIheypoovVDEGxxt9Qw4f1omHFux7COUJ0TVXRUNfBBDQ
 QhLr/bTCFpkfzg7t6PSBkQErMWsL/RL+TNvfiW5Je3jqOVpV4gDqWnjFc+YrwGhIH19j0FL84Kj
 Of1uZ+pqSl4oXn8huI2J6DqFPVHhUhYsEkD9c4bAp2QeYJEC6+zRXwWx8IBBfWj/S7WJ9PS+q2s
 lktYwWIU5LTo9pm8kFtJ4Q4WP67Nuq6u7MF90NkJSsRF6lGRKMw==
X-Received: by 2002:ac8:7d03:0:b0:50d:7632:ddb2 with SMTP id
 d75a77b69052e-51475b70afamr199095591cf.12.1778486200783; 
 Mon, 11 May 2026 00:56:40 -0700 (PDT)
X-Received: by 2002:ac8:7d03:0:b0:50d:7632:ddb2 with SMTP id
 d75a77b69052e-51475b70afamr199095251cf.12.1778486200306; 
 Mon, 11 May 2026 00:56:40 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:63bd:c2f9:cedb:aa32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm24431737f8f.13.2026.05.11.00.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 00:56:39 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>,
 Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH v5 0/2] drm/panel: support Waveshare DSI TOUCH kits
Date: Mon, 11 May 2026 09:56:37 +0200
Message-ID: <177848619477.10327.8599254658370877009.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260507-waveshare-dsi-touch-v5-0-d2ac7ccc22d4@oss.qualcomm.com>
References: <20260507-waveshare-dsi-touch-v5-0-d2ac7ccc22d4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a018bb9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=bE_KkYOeAPwlOS0bxDcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: j0SEG8BojxZg_iHoWIGxpsNBb1b43mrq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4NSBTYWx0ZWRfX3tvombhX+eH9
 iadkTTcCfw5BJrk/AmLpfakODc1Fx7E/KWYwGLl92gtmGSBJ0NdGw6asTIpJlCTtlx0Swrp0S1f
 XoVFVRAVZa2RKuYy9biEkNptLlrW+9asIMDWQu4VM2Wiypl99HsSt40p7Ubr0XSHr8viMxxTZna
 ePfotb5EUhevaEAeqTVAhkxz0xsIlqWShRW/BAVWSiyLE1KGsph/HIy578AJREokdS5Xwr2cJFk
 NF+uOZaAZP4IVAsIYAAf1zMbQdpc6rzt8Bx9JQOOaGLHi2knbw5orXgof26VoSs91BtpiTuJSES
 tMLxfoyCawMXxOvZaSOzBKqmKdddbwpBgs0auEmAXIJGNVzfBLDjBcOvrq8LmqUn+PNTY7Efl8T
 riMPyazIip09KOoysODMAzypC86pALMAWJYzTfddLji9pCNDMV+JPK9vsiXpxSruZoC/0lGoW2s
 3yu+D96c3yw9+KQ8tXA==
X-Proofpoint-ORIG-GUID: j0SEG8BojxZg_iHoWIGxpsNBb1b43mrq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110085
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


On Thu, 07 May 2026 12:01:31 +0300, Dmitry Baryshkov wrote:
> The Waveshare DSI TOUCH family of DSI panel kits feature different DSI
> video-mode panels, bundled with the separate controlling circuit,
> produing necessary voltages from the 3.3V and 5V supplies. Extend panel
> drivers to support those Waveshare panels and also add GPIO driver for
> the onboard control circuitry.
> 
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: gpio: describe Waveshare GPIO controller
      https://git.kernel.org/brgl/c/8cd19f5560218bf263b8ffc622ceb4bc329b3bf5
[2/2] gpio: add GPIO controller found on Waveshare DSI TOUCH panels
      https://git.kernel.org/brgl/c/79f44c8acfe66ff8cbed5626e2535245cfcf43cf

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
