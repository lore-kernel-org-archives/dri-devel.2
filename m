Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317C3FB5175
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 23:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 935A510E2F7;
	Mon,  6 Apr 2026 23:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WPNmE7iM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kOPUb6vE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6AF410E2F7
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 23:42:23 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LRlrW2009327
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 23:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VYpO7m3upf97kzILCKmwygjG6qLYrb/UUREkkw0XpvI=; b=WPNmE7iMo8AlXuFv
 LhXL/96gf2hPyUqFsxRyih91QgO8BJ0tjk4QzopxX7gnrsb1MqpFoebmDIE4+i2F
 WImfCgVrfnZO1ixifuIrR98ylwNpcViRwWYshCsNH1iYYvVCl+O3Lyhi3Oyo4Kna
 tzP4P7mug/qORAI0g2c0draN/9ke8hMxvhUlTZIJsBpNoOLmws4dlI2ybjOFxce7
 7gqn4beUhu+hGjtKhxYkKc3TajwGuF3elCS11ZIxcpeLQVn9jFKnjMh5y3nvqv+p
 JGHTeZ5mffeqfSOHMN3UwPP45kiYhLyR3Voh/A3FScwiP5nJDpV8ZQuzLBlFaCyd
 m0mAqg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrrr8hv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 23:42:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4031b86dso146013391cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 16:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775518941; x=1776123741;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYpO7m3upf97kzILCKmwygjG6qLYrb/UUREkkw0XpvI=;
 b=kOPUb6vESfTJ0tPZh/MKIw0ZTWIGiiPNzf9r1Sfbuwnrc9BZk3vn8WPCO2BM1YafPJ
 bQ7OM8aLT584CHfzplh4eec7xTYaFS5UIkycTEp1W0yukTnjulVtmjsoAgzJtFDWO5EG
 Xkf/WweMNsMRgObUzS+uircPtRp511N81FmheH1fnxPdqMEtjxxeAvBBzXwUlNQi0+iA
 w/IwrKtzqvmOb+M45MJXeTqHEd2837DOZBlp3jDElTHYbHvFFDcDU52NiH7ESsnuhVgl
 9zuZm0jBY6MhQ6lB39qyZk4yjcRtexgDG3N8Eb2RH35N3mT5R8OWfqIHsvMVNTJoW51q
 KNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775518941; x=1776123741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VYpO7m3upf97kzILCKmwygjG6qLYrb/UUREkkw0XpvI=;
 b=ICxgSMYU9+VAtcOYnGq7nB/PT6u1nyb+oZAV0iZzIUpDhk8h+9lSGTleEKeEylITn+
 xU7XUWvEg7l0GQaIDfIEJr5sRRZYx2QgTvlqxzMhlB6zwIz+GTX+QjuTsDd7hpZbiTBA
 9vpvw26rRW8CD5MdQJrD6LbUHR4QC3yVLLow4Y2NuFeS6/pdKMRO+qC/SOgQ8HklF/oc
 ZpFf27OxWxvw1R1ppP+y/IwKp2fa8E9hCl6IchNw0Kz8HReGjuUG5TF09IH5SUcdsk3v
 cT4fPA/MAt6VfNw0LkETqNG6M1RNUjHL9n98Y3++QaDblqPbRFpW9xpDY96T87gCaYFS
 0rDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWPW1syKqaGe9V6rOsSeJZE3cy6qgkz6JbtOl+kcXTw4+3QZFkjEvj+37CGC7S7op4LW1VNRPjiGU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxE7ArKoxq79g0TtxE0k7OXAICXTcVdF3d0OJNTFrzrRrVXO9OD
 jxU6GLA/94UpHF6niKRTo70Y+mgpm8LOfKViKWow/nWZEsIGh9gUcc4Oh6mx+7LBTJCEWd1N+bs
 bZPBMWFAQ+q/juQZA4xzAWeUoCdNUT9MdocgmzAGTlZBJwmqG0j/pI6hmT/iD8lcve/yhaYD41A
 BEey4=
X-Gm-Gg: AeBDieuDXAvh2tRPu0b+fLah5CQJidun+LARNF5cWWialUAmTiP6tajJT6OrGHzMYf6
 iopmul67HuHfEZMEvsMtruKA+z6BYhrQnC0DFbLnlBdqh2nv2gD/+pAZdRZIZfSIYVmXTCPZPYP
 kBWmSr2N4puDimIeLzwIATwcKpeaalM5/gho7lQ8tBN4YLmuTivoem5Bu/6t0Q4kPdQibWoWHun
 FPOaxwPxNFZwpINk9wMyDshj2EsftBFB3IFCIAbELdBTNy073f3WnSzpKBHk+iSNhAZH3DwfWbk
 D3ITOkunYReOSbPSx2NE86jcnxOFkSo5Mns7HUbMyMoSHJoLySmnxPfJqvfe2YRZ74V54nRL9fv
 9EEta4dothuy/XGaVG+M0pLKGp+ChQDn7oGwrgWMOgYj6CS6EFzbE1lBWWVrIaLq1rO8BV0AsJz
 /x+iC4fNevCHSMKRMKMjhuhdVcnf/pOH4eu24=
X-Received: by 2002:a05:622a:1801:b0:50d:7204:b532 with SMTP id
 d75a77b69052e-50d7204c395mr183731811cf.14.1775518941533; 
 Mon, 06 Apr 2026 16:42:21 -0700 (PDT)
X-Received: by 2002:a05:622a:1801:b0:50d:7204:b532 with SMTP id
 d75a77b69052e-50d7204c395mr183731581cf.14.1775518941082; 
 Mon, 06 Apr 2026 16:42:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd217c708sm33512011fa.39.2026.04.06.16.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 16:42:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/mdp5: drop workarounds specific to MDP5 1.0
Date: Tue,  7 Apr 2026 02:42:11 +0300
Message-ID: <177551403363.616257.10156402243953196092.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325-mdp5-further-drop-mdp1-0-v1-1-5ccee47fd1aa@oss.qualcomm.com>
References: <20260325-mdp5-further-drop-mdp1-0-v1-1-5ccee47fd1aa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIzMSBTYWx0ZWRfXwhN2rJDrSN/u
 o0lWu042jCciJQwHk4FwxuEzCl5PXCzZ1mTXzSU0kLKNpBUVehyzhjmI4xy0B+hmphulwaFgQqQ
 4bCAb6AD32soXatRymKjK5YaxkSYstZK5x0N4Va2OJbp+VEPhSxTVM1++IYzeu4FQL3O7vPB+Md
 l1qvKgZpvVR7zYQ/ZKVvrfMtQGkVoS0c0uB5nbdClZvC4D2lNYfl+rYnXVY7U+SFlBK2tMpbCnb
 UhZ0eyNQtvbpuUdzJBhlElT/zUQ1yur0irYJ5PfTQk/9uUoJgYnCT3NOamKu/eNlRkEdlEO/Yk3
 A98Uhts7GVt0W6j4HIFT6BVlvIxXp2JAEuteVTJK0/Prg4oi4L5x7CfGq4cQYiftiudrpflGZb1
 8cAxMypNQEWDLP9wTI24QkgEkXZN1Vk3jV7qTb5QIvsF4BvWbyugMferjuWSMBMLfiMOZ22XsEI
 zrZaOw37JP24OtD/3VQ==
X-Proofpoint-GUID: M_b_oWvfp81-zyd1GxAuKJerCCnPOo3o
X-Proofpoint-ORIG-GUID: M_b_oWvfp81-zyd1GxAuKJerCCnPOo3o
X-Authority-Analysis: v=2.4 cv=LquiDHdc c=1 sm=1 tr=0 ts=69d444de cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8
 a=-owB3-D08_1IoEjBxTMA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604060231
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

On Wed, 25 Mar 2026 05:06:06 +0200, Dmitry Baryshkov wrote:
> With support for MSM8974v1 being removed from the driver, there is no
> need to keep workarounds specific to that particular MDP5 revision. Drop
> them, slightly simplifying the logic.

Applied to msm-next, thanks!

[1/1] drm/msm/mdp5: drop workarounds specific to MDP5 1.0
      https://gitlab.freedesktop.org/lumag/msm/-/commit/e224e3a167bc

Best regards,
-- 
With best wishes
Dmitry


