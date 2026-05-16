Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1428CD4F3C
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 15:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E101E10E4B3;
	Sat, 16 May 2026 15:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XP+lXIOH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hfzd0jtZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 468CA10E49C
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64GCxKx1764856
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v2gcIEHC5V5+zmW6nZ7rTYwHa2UuXlAJLQXFWHz1tXY=; b=XP+lXIOHVEQFtbxM
 V5rN/AB+cz1T/pvmq8MyBHVJ8Fc7kO/029iL70BdgS7IiH3ndzr+jmh8v9AstqZP
 vbe6NzYcbDHlY/HecPLbCHmy7T9EobwnIxx38IAPlhkavTxYdOY5BfZuk+qs4C4S
 IEn3yuyaHRajuT8PjJk3h4KY8HxRj1DrO02wgaudUa7zypisXl4hHBGLmi2Q3gJm
 JMvDgxDrada0bEBbBnKiaBN5lV4D/gnFdyQ7IqDV9wFGSc1/286sD0SFXWEojQEk
 6R0A+hovoNNhmy0VUlmzrCQOiQbrB/crOaubXDkp1kNPEV8pu0FP4QIZHopfJeNC
 XkY0fg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gy515bd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-514ae0edeb6so58356031cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778945120; x=1779549920;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2gcIEHC5V5+zmW6nZ7rTYwHa2UuXlAJLQXFWHz1tXY=;
 b=Hfzd0jtZKEM2yiUA2g8KlytElNmnDJ30Qn2vw+ar8ZKr2OUGNpoLRYLGC4vKHvFFrK
 mU9nCJNLaLyu6OxUGo6vMt/lAF6VRkN2Z4xbMBmdTS4Sr5Q0/tnf25F6xdWdufEHbjXi
 p7+7CGCiovBMP6rHl6H8uDCPay80yxdl7LZLLa32TIFLAHFjg7sOmvWMtViWxjIb2GXT
 UyersnS1CMJ74h/OO46TV7i128pyA/NMmVRqNUpt6yh3r/RH7U9RQ+5rmyvtdz8hTaNG
 JKkB0UBhVCyEeTOk2iIL0klUIgXE31aIPfkymMGb3Lz6w49fMQlSi9bURWeRJRU7VQ13
 itKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778945120; x=1779549920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v2gcIEHC5V5+zmW6nZ7rTYwHa2UuXlAJLQXFWHz1tXY=;
 b=HI0oGVxKUu28O7yJUyansajGY2QO7HeCY6NDI9Ftfn9JdIMgDdbM8GKQQo9bjN/xoj
 dRX39m7zjcWefGiAXtSEtXqEMJF/Q8YMblCRYOShleW53XjfQWvQ5URlfl4c02S1Gqcb
 A1rMkGBGFwQmyCq08ofZa2U8L16TSfhhiqOSuOhrlte6Mni414GfTUJW4JTIa5yijtju
 p0g33IZPPY4350c6zVF6KrI6sdMtl1tBoJKyVFQU0n8sLer83Nnv05wm/sSVn8hndPwm
 vPk9Xc7vI34q/HjkrBvhw9A+xx9Y0sxqMNFNt8FCFb7H2ZahYDVx8beukKwuUvnXFVlF
 JUKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ87vrq5pZs26AMxXqNfCAYDddlzSE57lmYSfg0JekHvWbx38llcEW1naIxXcVnMur74spu6ldnf5ng=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyeGb1MFPvkz7s2QLad0iz9s/ngI+Z+2d1OHJgC2/0osEMrr4QO
 atcA6+O23tZx3TFKmcJT01vG89jac9Lkblh+GtHlRDLgdlzXVxNIs/KfotK62AiCglmcoCdIHiw
 m8q7XaJJY9+Izrp7meMHC+G8up8Vat8nqQK5ZJKXNU58UclCpPcDagS15gwaM6EACCmvyn3o=
X-Gm-Gg: Acq92OEDYzow+H8dT85I0iYQm2TxiOeWbVWO9LbjP/wuwkn8l1QFzdBN1kcuacFF9eI
 HNMB/Osqq8IEzV1LAoDi1byn9Co6HgxtRfTa0+F6mSiOBEPvrxlzuV3w+5c47JidcEmrRi9CQKk
 TALh0Cl+sAWxVo/QanoOwabN8FHf7cPXRhhcRfx90jXyBF0PZkFAGj0PuTwi5QqidR6jY3BAYzR
 oagFi3ynxVyL0is3vM2eT/7DtzD9ELfZ7vLd/FMlsgFVYu90B2WUU1xpPFJwchDHixVEdEO4Mu7
 AYg+EvwYBWDIn0YpO76VQp5zvXFdSrFBwNwnGQjqCkCyCwV3a+xMPjxVT+g4g2yAIYLP1Y1JTlk
 wRI3twG2u/RxPJMOIH5Keo9gdSuljP4U5Q3QVPVgpmPy9dIVgkLpGGATgZnNb22HxaMIY1MFBKO
 +R4RzkQ+BnCypez8a0G2qgpP6A69tTvbd2/es=
X-Received: by 2002:a05:622a:1386:b0:50f:b7b3:2ebb with SMTP id
 d75a77b69052e-51641928873mr165222221cf.33.1778945119676; 
 Sat, 16 May 2026 08:25:19 -0700 (PDT)
X-Received: by 2002:a05:622a:1386:b0:50f:b7b3:2ebb with SMTP id
 d75a77b69052e-51641928873mr165221841cf.33.1778945119241; 
 Sat, 16 May 2026 08:25:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164cd939sm2057972e87.70.2026.05.16.08.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 08:25:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 0/8] drm: writeback: clean up writeback connector
 initialization
Date: Sat, 16 May 2026 18:25:14 +0300
Message-ID: <177894506978.2448625.17152574519326512949.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Wusb99fv c=1 sm=1 tr=0 ts=6a088c60 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=XF3gkq58PEN6Oa2goDkA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: uPPuPAjc9EaOm1A86EqLqSOQSXNKPY_H
X-Proofpoint-ORIG-GUID: uPPuPAjc9EaOm1A86EqLqSOQSXNKPY_H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE1MiBTYWx0ZWRfXxjtMB//So6DL
 Ek1hmQMQSi+91oJWkRzaCqrm5dWJRrxSqw1Zd3m7e9oe6cEDpOmO51qsg9Md9japfbsSWOrHahu
 RYrP4Wh0a12PVzBsPJuiERgBykxB9JcklnZZaLWnjNji2/eS8uV7xyWqDvcOjZFV97YR53N+sdD
 uDeXIrQ+bNT/gBuWJii3giZ9PdmlHJnctX6gJ8TdT713jikTtSY+ZaGQNGUk+uUL8gCIA4+1hXH
 NSt9pKBaEy4y1zJZbWAO8QbSGcA9BtbCV7ReJDNmqyvRTFxG4EnB6bmEErHiS2nshGiLK+w01SI
 JMHMuMykYls315j2t944UEWAbEerg/rsu/WngSi0vicf8Fh05uFCuNxN0ifHfibcWTJA3LLcbpg
 QVFyLEfg3RBLQpgxPj18CAZeRsYnOuCitZ2M9A3nkaMPvDQeiPm9oHzddm7TtH0/72iumMNUUcD
 lijfGqxNujzrijsGADA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605160152
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

On Tue, 05 May 2026 03:24:57 +0300, Dmitry Baryshkov wrote:
> Drivers using drm_writeback_connector_init() / _with_encoder() don't
> perform cleanup in a manner similar to drmm_writeback_connector_init()
> (see drm_writeback_connector_cleanup()). Migrate all existing drivers
> to use drmm_writeback_connector_init(), drop
> drm_writeback_connector_init() and drm_writeback_connector::encoder
> (it's unused afterwards).
> 
> [...]

Applied to msm-fixes, thanks!

[1/8] drm/msm/dpu: don't mix devm and drmm functions
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c0c70a11365c

Best regards,
-- 
With best wishes
Dmitry


