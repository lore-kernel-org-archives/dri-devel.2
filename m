Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33E7CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A175310EDB0;
	Mon,  8 Jun 2026 06:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jgGajLeN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CsQo4MeU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C297D10EDB0
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:49:45 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586Otjs2384582
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 06:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t2UwrLrsTEur2MBj8Pv0hR0nKiTxwW9rEtX9yOkSYX4=; b=jgGajLeNzJkw9IfC
 R10iLNmQWAbk54SLZ8ml1rDNqBgPj8+DtuOhQSJ+7SMoPSQZ3du1smSYgH15ZH5I
 patshtk6YhJM/MAhViCPBdjNQd+q7J+AWrV5NJGLK3ZcB2KO1w/1Payi+d+hpnuL
 gzTU5JY6eEsAmcQPkSHrv7JOwCo+AGlWaAjnfg7VD8Xrb/CaNy9E5+Cjm3L5747T
 7gj0g0htwaNbRMuPinlLTD5bafdrjKXPsarvUTNKQq5DjY3uT1MGlLJ8SXNqcze2
 1TKqjH0q3Tlpbj6vIYPhdfd/4bjhWPo8MDfdCtieXV4SbC4aJzhDM1G2tuRIkeSV
 twoJEw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1e843-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 06:49:45 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6e907a982f5so6848436137.0
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780901384; x=1781506184;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2UwrLrsTEur2MBj8Pv0hR0nKiTxwW9rEtX9yOkSYX4=;
 b=CsQo4MeUQMzIIKw/AAK2g8vsQRx4dU1siAmNvy+Fo4ww/y0ezo017k/z8mgBY2tUqF
 0hdLHn0w9PAq/hTDWL7KDrje6oSaAt9L53eKNygZALBTYk/nV4NoaMGrtaeR9udCFKtX
 HJIaolzU+eR8GH5nLlz+nqfkHngBo2jHs8ZS5EZsGVwYzMmvFXJdTB2/18LrsYsRsHJ5
 qmXdjZ576EMZxwYXEztMpk7i92saZ8/5ACX+4phhUnUl/7yyIEgvCPaDnqUndzU4fQLs
 g0z2g/ogyKdEvPaTEuNfzQQmVBgnVmBx6ceZSz/i9tREIEICD0mhw949z7aSt/QrYTZC
 Erlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780901384; x=1781506184;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t2UwrLrsTEur2MBj8Pv0hR0nKiTxwW9rEtX9yOkSYX4=;
 b=k77kFHPyHv1Gc0ZYk0LU1vZjWZgIzVj1zcCjm9UyfT0ggC2FVehOPWPl+XkLmDLGju
 6Tskqey271BVkGFJWaH+GNpJ3dXWuX7gL98U9vvapey6RyxvEa7GnzeBLsJLeranqdwN
 6oCMhYHkzQzHDj80IFktQxUO/cgQPB+l253QvD7VwgxujNtNzh2MuwcT3UzrVXdvPbgn
 DcdMInjgA7vhVNQMxamvZdEC3J0UAXvwiDb7YwwpCxI8oio8dchZ/8jNC9dxRB9tunyb
 DW5cOVhUTflro6t40QdwTUJ42xmHV0G95C7kmivEDdoH74iQ3c8jYWWyL8ZIeY0Wc2b+
 F69w==
X-Gm-Message-State: AOJu0YxKOEUMXtNb9RFv0OAtoMH/8eE6jhLcQqMxf6tLi9bVF5w45U3y
 Szj0oeZqEHsxpC/prXQQQo/dhTCKq+0Q2faxuTevyl80w9/HCYN/xQKuT4ACihGiyy+a9e147vX
 oYF2Iy0VxGj7W+4nktAzZOl4Ra6NSvnuV1cozNm0Dk/NvprrvsSkzFZgALqFVKAv5m6Wgz3A=
X-Gm-Gg: Acq92OHxttSVF0cF98FdLqESfP5sAhIwbZNmLbxD0b3bwjkxbZ+q2SKZhGtWW/JdiES
 09zD6Qdy9f+ve6USb5VAOCOvkgYgcgwVVssfpgWR0r0yU7RjHuIfE1aXGJycYUcqtKyf6jfaBI0
 oa63c4RtfThqiprYnr2H6JHLfi5aYbt7BwpF8tuOgbs7A2/rUB2scg7SRjsn5kdrX2VBrFE4pti
 VRr1W+44KMIYW4PwSr02e8busYzD3Dk06ktpWKuoFfDP4KWdqSyah0unDXWGLbeSuit3EBbpSe9
 o5c2vofVAxmJZrRrSI/ChpDCFvue3rcZId3cqaclrzaXIELzVJc1wYLnXd8JKuo3gumLRc3OQu7
 PntmIeNB6KTA2l2qJKIEJKum95W1DInDDFiw9MtqJIZDDG9OyeeyYeVKrtpEkz6jQfvyS0pIbps
 0orrqSmYe1LbMkTRjs0r55zpB18nEsQsnJe8zpG5jXxj+5xQ==
X-Received: by 2002:a05:6102:ca:b0:6d7:a2b4:bedd with SMTP id
 ada2fe7eead31-7002b70dd8cmr3080063137.5.1780901384321; 
 Sun, 07 Jun 2026 23:49:44 -0700 (PDT)
X-Received: by 2002:a05:6102:ca:b0:6d7:a2b4:bedd with SMTP id
 ada2fe7eead31-7002b70dd8cmr3080045137.5.1780901383963; 
 Sun, 07 Jun 2026 23:49:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b8880basm3573760e87.0.2026.06.07.23.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 23:49:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260528-dp-connector-hpd-v3-0-d656eb1079b7@oss.qualcomm.com>
References: <20260528-dp-connector-hpd-v3-0-d656eb1079b7@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/3] drm/bridge: display-connector: detect DP state
 if cable is plugged on boot
Message-Id: <178090138226.36483.9187417905937985525.b4-ty@b4>
Date: Mon, 08 Jun 2026 09:49:42 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MSBTYWx0ZWRfX002wV83ur/OL
 QZRjpBzhAKDE91x6gWyWzBV+Jk2C4BE16vddT4VZA9HsuvAPf856LgIqvEQg7LRWlQEYs122gLx
 5DcM0JtVSU2kxQav/g4EzKZBtWQfKF/ycjVoihvoMNLPkJ963v5dTzuwTeXCEPC5zaqQmqAHFIA
 efCTHUWR1yBm0byoIkWYanJ6WaxljSoCD5l9bO8aiLqpZK2POU8CDo+R4Uo+nXTRT5PjanMrBu4
 bQmHOr55J8Ba6BXTnCp8DSoEBUGRJaqO90HpfacXFUgAuqGNZNjY/ubEbWzhPuSH32y5hdc1h+C
 Vz9pP0RLYTQOGX+un4izbSwprJHYlbOLxa3vNnpe8+Sd1Vtmb8rdK3IM3zXMWZkYYk+e3ryKi84
 AfvCXwSc0aZCs7YCMeR0NedQA4WoaYHVsIDF96gZYChmYbChE0hZuSjfzF7LWi9ocHMx+c5ZbjG
 x1a04n8GyJzAvQ+voBQ==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a266609 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=U5Edx-QnV-FVL3PtqvEA:9
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: m956-Sq0QRZVTmmpukUv1P3HHHNhD57k
X-Proofpoint-GUID: m956-Sq0QRZVTmmpukUv1P3HHHNhD57k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080061
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

On Thu, 28 May 2026 10:10:47 +0300, Dmitry Baryshkov wrote:
> Unlike the USB-C AltMode handling and unlike the DP controller handling
> the HPD on its own, if the display-connector is being used to handle the
> HPD pin, DP controller might not be able to get either the HPD
> notification nor detect the cable state if the cable is plugged in
> before the system has booted.
> 
> Make the display-connector send the HPD notifications during system
> startup for DisplayPort connectors.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/3] drm/bridge: split hpd_mutex into two mutexes
      commit: cd0d23939b8775482c30ca7ab207f185aecd6555
[2/3] drm/bridge: display-connector: don't autoenable HPD IRQ
      commit: 8e9c475060bff87077cfa3bd42011edcb7fb3b0d
[3/3] drm/bridge: display-connector: trigger initial HPD event for DP
      commit: 60dc0946bbad3eef8bc66a5a8b09b98dbc6e09c0

Best regards,
-- 
With best wishes
Dmitry


