Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDD210F286D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E6810EEBA;
	Fri, 27 Mar 2026 19:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Etlocc/3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SEsTasSa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7540210EE4C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2S9f1774536
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k9QlFoFwXhe0LUmSue/6VRw3W3wz42yC6QquxDczBlU=; b=Etlocc/3YNxM1KV6
 eTPvPiYE0rR5coEojxgfIOx9af1AyCj0YMqB5C5nIIrDKcf+bAeoLDWY8Fk/M+sF
 Po3ZlN29kNSNHBeMCLpYf3BJ/b1muydYuCp3KnBeBpFaFKwwZjBWx7L5n/MrtJD+
 SKXGGm9VWqZNx+7tOnHljA06XdPmFOQLj0rMRnbTJZ55Qm89xP7v5K8V77MJkeav
 IJeE2TwYb+sbl1mugOYw973XeqiGySwEPZ0JO4rvtpnF5h170O9N+wCirxzxnnYK
 sIxpNG5Qv1adwbPiquxyw8/diHNsP63QoRGDHI/ciBR85e3/8V1cNkkpXGYJXYYW
 eZIrDQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5vvv8rdn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b34223670so54600141cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640883; x=1775245683;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9QlFoFwXhe0LUmSue/6VRw3W3wz42yC6QquxDczBlU=;
 b=SEsTasSarwMSZB7hJefViTb73Ofe1WTuqUEXzVDJ5qyQ0tdys9nDQsLntPMSRJ3tIN
 27J1hus2HX9eJRh5MLUJlWa7iq1Aqb6xOZArKRPAVHw/VWcOc7bZ/nhIOdUv/mVal6AM
 +A+1rd0ywyEs5j3BIbzzDexgZ+pcdlMvmFYRIYQOlNUYJE/SB6S6Rgx4A0xJwp73l/nz
 jDFo9UeR0IUKPLTL8+ZDZyL+QRR5stQ3V5tDAvQllmlIvEV3eWmGErMPhjuwkEOPUG4l
 Bbgdpdffz+v3nxhZvWyZtzcvLiILoWYFyRUA74I2Wjah9SugrYrRJDTWV5bVfuCUnf27
 E/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640883; x=1775245683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k9QlFoFwXhe0LUmSue/6VRw3W3wz42yC6QquxDczBlU=;
 b=goYwjAYXlw8rz3nx+g38BvyZBtADhZIZNBpLzwdmc2yvbeUxTM7KwP0jGZ8IrPVDEb
 n9TKc2+ydtv3c1DA5n7WRA0iUauo6foH4xnq/dVQEu/cPwcz7OfW+Lovkf3RnflYfugo
 6XYgkirDTmw52oU4Tnx2bqCobwhYnKFlyC1O2Rz7usGngNFet/b36T4jOpl25mBRKe8V
 V0z1qe+0oxmw/Y4QgRmaP91Y5icq528pphb8KhwVnt8lVAgHo/gUhK8/uthndacvCh93
 aznIq+XZMNPRlcgaUY7X+EKmMlMZ82B9ZHZxm83u0JyY/bNHzPfb577nhaS4EQoKr8ow
 yw/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfzXYapVDAkkn4djif3cSu1Nvrctxvh+LkVxafwL1jvdcsNLqW/gSR9MM+e+Ew1/FwOzUt7BhcURM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7JeO+EEV4tbBai55NHCrLnZlA50ZYgbEDDL2MAUXcdI835Mx+
 63uJys5KsH+btMn3lJbuyQltqvgtJXDco2cuIbWWVBce39wqXCYlYRbHQ2b0i0dIrKqGa+sK0HU
 rgvhfsY0XHC9lvF37pRwyqQrnKAB8XXzc7Y4hLsVKAEOPQrpMCj/vDICxoQ86kK4QQATWI4s=
X-Gm-Gg: ATEYQzwzMh8GCg+wwoivrv1HIMIM+lYg1w1qlurH0Mye85J7KWeQlAU7mB2zFcHKCXa
 drEhzfM5xZrB89OtkuZNIXWZE7m0zJCo1al3kF9JAVTUC6irSkzJNM4i5/Zyqq2HQP3MP0xVrNZ
 usFACwoLcxCYpwYqRyGDAFhnIetYpwChKuXaAjEgcTDGT74JVcPGUayOd6ETuZf6RiZafehcjIa
 P+BTpGOLRL8mf3ZD+Q1ZEASyjQnWqUFGk2+bMS6PpnR4SYM3xu4FwKEpQXEcUGLC8llJ+MPcpHr
 I4DcY430QR/pAiJ+bQ2vcx6/S1qeWsYUsGsBfQX17RYwGbU6Cr2qBhpG3jerRUZVEk2Bi4RFlaa
 RW7iBXvPK634e0So2E4g09zphevSBwShkNLLTfUfda9mFJOFsSUGypUDnewDbkrrDcWIpqOAx4J
 qqc0XC0aJMMKu5B1cVxX/+/XyCYEg6jpmz
X-Received: by 2002:a05:622a:82:b0:50b:3a6d:db64 with SMTP id
 d75a77b69052e-50ba39359e3mr56105251cf.48.1774640882978; 
 Fri, 27 Mar 2026 12:48:02 -0700 (PDT)
X-Received: by 2002:a05:622a:82:b0:50b:3a6d:db64 with SMTP id
 d75a77b69052e-50ba39359e3mr56104631cf.48.1774640882505; 
 Fri, 27 Mar 2026 12:48:02 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:48:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Lo=C3=AFc=20Minier?= <loic.minier@oss.qualcomm.com>
Subject: Re: [PATCH v2] drm/msm: add missing MODULE_DEVICE_ID definitions
Date: Fri, 27 Mar 2026 21:47:44 +0200
Message-ID: <177463970847.3488980.4980999830021839231.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260228-msm-device-id-v2-1-24b085919444@oss.qualcomm.com>
References: <20260228-msm-device-id-v2-1-24b085919444@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uiTb-DpJsuQOgV6J_7EV1BeMeK22MY5F
X-Proofpoint-GUID: uiTb-DpJsuQOgV6J_7EV1BeMeK22MY5F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfXySOu2DYbs5Kh
 amNeWG5ITBqXt7QxoPGYygXkEJOzViYIRXDVHzl97UsAwY79m/m8dgxezdHEpjTOm7mOZv2IMNu
 a7seNVv/xbqFN5+Yn2hjr5QBuvnwvFbnKgi++sqbxTfYI96i5yl2ip2oPuJfY18PezhTGAzbDog
 QXaxxKh87R5f3RBS6mA9FaX+aFAeEF8EFyDxw4h+elWBAAUcgBjsnUnXY42jYJa7kij1bJPi8oB
 fVOMsZwE1JNJPoVteb/r1rh64XbDuoT/JO/IWxJmgaQH+/vjWuHacTnEy0FDBwa6XB4emYG9rNG
 4tyEP4VeVcbvHjhlInFbZxz4Ye1l92Ls5JRKdlU3k7x9SutRnkqORq6+ed84T4bYPWHbq0DQE/q
 OxTRJTRF39kPZm1a3jR5JUpN/v44U1YIwpfkfrsKmphIsch8L5hDneY2gCliePiUmx/bsOC+xJE
 bSIgrSQCXiInceUTgKg==
X-Authority-Analysis: v=2.4 cv=PL0COPqC c=1 sm=1 tr=0 ts=69c6def3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=e5mUnYsNAAAA:8
 a=7BoRyOUxG-vAO69hLskA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270138
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

On Sat, 28 Feb 2026 19:20:37 +0200, Dmitry Baryshkov wrote:
> The drm/msm module bundles several drivers, each of them having a
> separate OF match table, however only MDSS (subsystem), KMS devices and
> GPU have corresponding MODULE_DEVICE_ID tables.
> 
> Add MODULE_DEVICE_ID to the display-related driver and to all other
> drivers in this module, simplifying userspace job.
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm: add missing MODULE_DEVICE_ID definitions
      https://gitlab.freedesktop.org/lumag/msm/-/commit/b21e85400ce7

Best regards,
-- 
With best wishes
Dmitry


