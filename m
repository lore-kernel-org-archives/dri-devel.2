Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50D2C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 23:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A6E910E4FD;
	Sun, 12 Jul 2026 23:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y642xpEL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kdlSo+ey";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C6010E4FF
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:58 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CNU30p4022029
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RjdX/OYhR2ICmK0eWyh8tZwbbnvsiGpI+rl6rDd/oLw=; b=Y642xpEL4pdWddGv
 zGFeBqXgXsenIJDE0EFh6g8RMdWpIn0oxKgKUGJtue7/QkRXUP3WERXTxXqaRCBo
 CdzdIw67PDR1aP24ZuiqAgqKHHaWfKZcz3j3pnT4DUp+ZmWDePzpHFKpQFsUhJaW
 lwNRGE/RCjyrUXxqyumjUfp+xokDlwrqHZCeMFn3BkhlibOUoQ+qGyO6joz0qMZl
 GNC6WAUYNf8MBMx5Fe42RdzGaF9IC8KGrHbIKOoljWNtex2c+HYF9ly87NuqrEoH
 MqNyXY47jLIMhQfZyVvVzx0K7ULmpx8b3WhVF+7QjoLfOcWg66/Ly9GVPByC0HEd
 30lJUA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn385r7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:57 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f0867a75ecso68399906d6.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783900017; x=1784504817;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RjdX/OYhR2ICmK0eWyh8tZwbbnvsiGpI+rl6rDd/oLw=;
 b=kdlSo+eym9Mx6UjMdR0dwxGDiXiLmVeo8EJfXkqhcY/3xyPVdVqXzIGb3bWngDLdFY
 dNiagWY0q6nsOAAOYznZMccKmVGB7D+QB6t1ySnKGx6rywWMJUD4luCXhyMaz9Y5BUZ9
 pBTAtrm8OZ0cmx+3yj8NYTDOpA7Gcw2UTLrRTnkceAyrLIkHHyI2rjIfiehrmYwrXIL+
 pG+jdMJpGYvxhqyAgXJlxeZSSTHbevKd9RBQCcEhI5Olbf71Cu8uq4flV4vcPl9doe4w
 oSNJ5fXYxEOyRHDKy46NQgZbe6KWIggHbMAQDn48hd6epnVyTmS++6NEy3F5EtfxO8eQ
 vAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783900017; x=1784504817;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RjdX/OYhR2ICmK0eWyh8tZwbbnvsiGpI+rl6rDd/oLw=;
 b=iqZ4qIWpWqe4rwcr0trBQY8zF1UyMLzzqwEo6Xxny8wjy5y2b4I1KN6j9Rzi2UhZsF
 aFD/9je9Y5GfUl9Bz4ECy2+xokoVEm8vT8tZFT6z8zxlQWkLTBR/x4JXgHOhHDQ+zTOB
 aixt/p44uqn24pKRXa955eIOvb87maPbArPQPPy0PbhaDNURO94zECYUQnbSZNBOnnpc
 F3bJliZr2ESMtFsk/IKjMQ9NcBdHUGaOzkHxQZNa+ev4dPMnUe/gtNsIFbHYAC1lDVjq
 4NeHTUNSClh2TZQnY/mV1GuVyuWgRr1XZMu7FV/dRev/lzuZyy3C3KXUIcbVdIliqYaG
 8SCw==
X-Gm-Message-State: AOJu0Yy7TD740GhrnzaebgZd/qbW3zUC/cZ+Gd53U2yC0dk18EKygHcG
 cjkr1yuztLbVEFL4CdqmWcuMg9k5DQWujh9vhMXQZXFcAQtC6eO7aUNu/vYcmvY71WhE2Q8dQX/
 amm7DQ8VzNtQULWOo2co1JICTn9kX6M/ze/4bL40isdyNCsBO8JQ9qFvYhSo+eA0obnwT5+UrbN
 WXRMY=
X-Gm-Gg: AfdE7cm05u57eHkMAnf3U08v5lICO7IMs/FO6cr1MQxPPK8QnChmQNSOoKz8AIGPlHl
 1fTV+meZC95leiBgjWJ4MaFkTM0ouCOprVYyyP7HKL3pca3n9YCNXlZH+cEdKJJ4T5g7v5iHa7L
 /3tfK9bQ9/4WhIma41EukePRpHojT9Bp3PmHXz2RbpIt3jHUaLzmRn1Ox5BO0L56hCxKpwVXxe9
 nd/LaaUk5pc7XVwNyLf/d7XLb7afrStxhGbthkPt/lz3EzVGhL2X338s1nDS4QoVqWguCMivFBv
 wygDBvcmRJpO60Pjet23MHI+vDQb19KuYrCHcm1lhL0HRG/US2R07UuREL2NhSifR0lsVb8mpba
 UpAXox1TqKjP9BJufpA8xmEDlk9U2e3BAWLP6bxYxuXD0DmxeQ5qCNNIjE8SDmwYvIHsdM3XhQs
 PkxqURe8IhdYux5xJuzIR86UkR
X-Received: by 2002:a05:622a:4c0a:b0:51c:9c2:99f4 with SMTP id
 d75a77b69052e-51cbf2bbab5mr70457231cf.64.1783900017120; 
 Sun, 12 Jul 2026 16:46:57 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0a:b0:51c:9c2:99f4 with SMTP id
 d75a77b69052e-51cbf2bbab5mr70457001cf.64.1783900016742; 
 Sun, 12 Jul 2026 16:46:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01caaf40esm2371357e87.71.2026.07.12.16.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 16:46:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, Rosen Penev <rosenp@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: fix parameter name in
 dpu_core_perf_adjusted_mode_clk kernel-doc
Date: Mon, 13 Jul 2026 02:46:41 +0300
Message-ID: <178389962792.1434604.9113106543180632630.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260530201342.10538-1-rosenp@gmail.com>
References: <20260530201342.10538-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfXyj1w3WiKY6Jn
 WO5HM3GxMiJXwzFC42mffKqTvaR2t/TZ29skReXuYtiD/b3K5QdMr+BU6iloWp1dm43d/lg5jsK
 tf01lH5AmyV/q0z4fjRhUKG5KgamnOTP+qhe4qkGPQVs05KDY/IL9KmAvL+bks5QUto1SaAoeqn
 Y/e4L62IhTD/NWtgofVxu6M9A3RaWUDXpaYBVBB16Gy4yWMzLbW4E5sTm9UPfZpPoyZ2gIHqAmr
 +z74n+1NVBWcB/s+2qf4ZrNtdw1LHIDnbKUMfc/IWCKo5B9whcegEAVQyhL2SeA2RKsTpajbnd9
 CsElPL3+zJb3uFWemckTZ9M1RhMXLN0geJYQPSe0QHWCvGcDgVXOuEFiSmGjAkJ3HRmmulN23Ct
 /H7ZtiiUr1ljMuAkDymWOSKJ0ezKWeRQCiEcptdROLH+OhfM7BOle60EDuooQepVoHlkDw/mf12
 By0xu4/FTgbN27di44g==
X-Proofpoint-ORIG-GUID: Fv6btjxNgm1bydq2cb4TZ6tWCvMqnqMx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfX7zArm3AvZBaJ
 ynlE8NWtHWN07ocyYt6+lGsV4GD8fBagWua77StbytptF2cDtamFIog2FTM9Swcl0uKuddrL9m2
 IaGagVa5qmAHtzWjD0LOMUFP1NYSV54=
X-Proofpoint-GUID: Fv6btjxNgm1bydq2cb4TZ6tWCvMqnqMx
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a542772 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8
 a=L51XAS4xMaKD1odKDw0A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120257
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

On Sat, 30 May 2026 13:13:42 -0700, Rosen Penev wrote:
> The kernel-doc referred to @crtc_clk_rate but the actual parameter is @mode_clk_rate.

Applied to msm-fixes, thanks!

[1/1] drm/msm/dpu: fix parameter name in dpu_core_perf_adjusted_mode_clk kernel-doc
      https://gitlab.freedesktop.org/lumag/msm/-/commit/14ea7c582879

Best regards,
-- 
With best wishes
Dmitry


