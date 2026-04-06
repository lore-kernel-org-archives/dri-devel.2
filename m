Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520E4FB5175
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 23:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A272610E2F3;
	Mon,  6 Apr 2026 23:42:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YeBexRlT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WBe2AzzO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06FCF10E2F3
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 23:42:15 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQNj03537365
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 23:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J6ZEeITrOvR0oJDoGpg4mIp8IqYaFSmfsX+gGF9TPAQ=; b=YeBexRlTjU23KzH7
 wzNautZn8cwHsggRIQwx6qBt1HP+nJNtDAf6XC5j5t5qNgUCkc3T4VTUPC//3cgB
 3lh+T9C8HyHHdr7BVkkfo27SahAyM0CbvTXVeGFQq2/aV9H43s9j5ey1a4r2BqR0
 hOe913tmNILbOXmlgVniQb5qCw/vX+hWFsnrNJ6vn8IIDyvThG/pj9JFksmX9h8H
 pwIj+jZrMTRIEbovGxGXWa5lQTuVxJ4KJFuCaJhgPy0XgW25D/GzU+p32UmvjIH3
 II4+01wzAXUM+pIpK4XJV2abJi1rij79GU+b8+srqFYFxEGdNPPeab8TuUVJ4jns
 zAYXRg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmra0911-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 23:42:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50da529ff48so1237731cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 16:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775518933; x=1776123733;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6ZEeITrOvR0oJDoGpg4mIp8IqYaFSmfsX+gGF9TPAQ=;
 b=WBe2AzzOhQkcI1u+X+riqwz9VrzBSANTG52anbifROrg7CZFauy83A94ydgcpVJgsH
 47AhadgNQ+t/jjOmxTglCPIp9Cdb+IvruiyMNzoKJcxekMxGr7IZvb6rW13E6QmirFUd
 eTl1tbgoz6IHsLWmqc56eLc0PGus63+K5jqb40LpgyrUDIe34WT/CZKxv0pD+AhP0ENt
 2MDO955Mb1aRpBXTeQqA+XcsT8gz0/bfjqjIvaMxUDbTwO/UQ551pcpPhdsNp4u+enZC
 z7gdlsFiqKBYeMd1Z9oW92OCaXaOtrjSdspSVkFnAg9HstHCieZdJwucNxzT5OCC2U0A
 k0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775518933; x=1776123733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J6ZEeITrOvR0oJDoGpg4mIp8IqYaFSmfsX+gGF9TPAQ=;
 b=VAGHP88Se9gFGHjzq2EJKhEwAmXGF7+EmQo/mZhZ1yCdQt0doZl8zYbFlX2It37Rwj
 tK1orXSgmX8agF52KxC/7DUu3eUB5Z7tvYPM3EtLNsOARhGNcEju8Oy5kANuAi0wNruM
 ebLhayZyxZjEp8LqxW03jdAwhVS85o/DsUQJEiVJUGgTc/qxBvH3xY4PVsc3BudnxOZt
 Rk0traj4KV+UnIdaUIa5u4kxxZGmTScOxXOtsqewjbQnlzslGE8mMveba6zyidwEjK7x
 Gf7nZFjU2b2CAhF4lKY2wzWSsN8vcPWin9fchrPQ61T+waMnVEmxUcc/VLsyOrNCatVx
 xrhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMQlajSHMA5gNlWq8VWgpqgK6AC2s84PO613YmyD1dH1o3bFLc+EMzegLUHHb5V7H6pxsFbrlcvzQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxr/5Xr1AKstUKL1Q7Np/jqd/eMmM5tLaXUmHoHvitFeZcZM7h+
 q2cyWyH7D2SQKEA4vLRYwWTHFxa2NXOuoXVC5ejCFXi8O1rbV49fNmo8BsXrPU1ZCTsWdJmfgM3
 IMjhIt8o5n3eq5Qyluvg+M4WkQsMLZrcOSHCdRke+KtYaEuKFaLJypcnK5Kd95Atqv2ufS1g=
X-Gm-Gg: AeBDietvdguu6x3+440qqlB9jMTzMUXVxivuKf3cHszRP7TFLnQ8/hZC03/dwtWpoHR
 UuHISvBGWF8Kj+v6Ajm4QWjoo5v886HXLQ/j+8Nm4D7K3tDhwB6ivUobFFhecfi+A072EMZF4aR
 XUVHmVUYHCRKUJdZxNnQMiT/Lp6RaF8vCjAhZw+xPlLbrIB+rKk/35KyaFlId7lIDTy7Lhk1M3y
 Dx3VOppLWUXdsnl8jP9lsttrg6cq2mlebO0Dzgj32sndvjY7SzifMi7Z+xfAeG80dwIw/ikjDi5
 MTuEVoSTQr3hw1e38BYPgFWgrzq3rbv3ravZDntiKDP6sxNXgH9hffv8O6IVaZ00rd7hCU2jW5S
 0qOt1En5tasvgy/btuC+a8NTILD+b7M4GO0Zaa+fBmILuBhuCX8gBzMgzNxjtRNQEC/n+qvQz+J
 +p7zt8NCPf6yTeZ33/bHFX8Joedv3uAwDH31w=
X-Received: by 2002:a05:622a:1249:b0:50d:8d63:3899 with SMTP id
 d75a77b69052e-50d8d633997mr117435951cf.14.1775518933517; 
 Mon, 06 Apr 2026 16:42:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1249:b0:50d:8d63:3899 with SMTP id
 d75a77b69052e-50d8d633997mr117435611cf.14.1775518933071; 
 Mon, 06 Apr 2026 16:42:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd217c708sm33512011fa.39.2026.04.06.16.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 16:42:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: Re: [PATCH] drm/msm/dpu: correct DP MST interface configuration
Date: Tue,  7 Apr 2026 02:42:08 +0300
Message-ID: <177551403362.616257.9807566630197414296.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325-fix-dp-mst-interfaces-v1-1-186d1de3fa1b@oss.qualcomm.com>
References: <20260325-fix-dp-mst-interfaces-v1-1-186d1de3fa1b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7s6W9ioZ25-dz5KN_4Tcq4jRu26WTQ42
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIzMSBTYWx0ZWRfX+NNFo5AFuzOm
 i7MgSiUuWsMVuqszqmZqCJOS6z1beDdlo5eaWxYdYBWP7p934IuPYQJWMZowZjOVuyXMSO03KoE
 Tf0AkuGUXRqKnaadpwdlvqmVYfwdbMFdLz+/a1803dOL3FzigdAjjXAQQd3tAxWRoe0oWgAzAcV
 pEOVAi4i7bXxYlQCO2GDIFokcH7X7ZYs0LE/WpEeiuCawHfx5+5IMjvf2tKuTZqtq51ilfGW3oe
 rUqV9UZKn9aqqP/b0SHGqpLI4i+jf0h2d6xYjyq7R8C7sfpDgy9AdcFsKIydTQdvyIxKt7hPOnh
 1Tj+bTDvdtqVQs01b9VfX3dOrjAfcmiXOFem4cEHLuCmY4IAPs+HEwGQHrczAJJV/ySr/2ii/Yw
 QB6P6vTWQmtFtR41L4FN7CBgKR4SEhGR2NsHwZNA7K9yfHmVdAXSpft8jZZ/ot30IOlwJl5WjIj
 8lhtnIDXVFmAvu9cMZQ==
X-Authority-Analysis: v=2.4 cv=BKGDalQG c=1 sm=1 tr=0 ts=69d444d6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=e5mUnYsNAAAA:8
 a=6zy0MCPgn_BX5wD5kqsA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: 7s6W9ioZ25-dz5KN_4Tcq4jRu26WTQ42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604060231
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

On Wed, 25 Mar 2026 07:32:27 +0200, Dmitry Baryshkov wrote:
> Due to historical reasons we ended up with dummy values being specified
> for MST-related interfaces some of them had INTF_NONE, others had
> non-existing DP controller indices. Those workarounds are no longer
> necessary. Fix types and indices for all DP-MST related INTF instances.
> 
> The only exception is INTF_3 on SC8180X, which has unique design. It can
> be used either with INTF_0 / DP0 or with INTF_4 / DP1. This interface is
> left with the dummy value until somebody implements necessary bits for
> that platform.
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/dpu: correct DP MST interface configuration
      https://gitlab.freedesktop.org/lumag/msm/-/commit/469df8c2b571

Best regards,
-- 
With best wishes
Dmitry


