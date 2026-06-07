Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C0FCD8C88
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A50510EA4B;
	Sun,  7 Jun 2026 14:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kSG1HEJx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tw4OkKwZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FFBA10EA4B
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 14:02:03 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657BsIYJ096032
 for <dri-devel@lists.freedesktop.org>; Sun, 7 Jun 2026 14:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=E544aA3Xdhp2JbSmxDZLkz7HqyAP4q+CpKz
 42TXJzUI=; b=kSG1HEJxZcraYKRULhaGnYgRAfkHLmm3Aokfsb8X0qkrcOtyawE
 WaniOE604us3UP52HliDoFPclH4G7NlCMbTtSspV1pmNO26YE7jIwQPHtyfBbvb2
 K9T342wXMtza3MXWBzkmK7VEJ0HUTjBbodKLnk5aGNQKcth8viMeWblhftPdKqxd
 XbjddRryHWRzq6STTIb3ygigqv1WI+cRsSlTIS3IKJCG/rcBu+NyB2MreuKU6r/B
 hWllOfUpJj7HOV9yuQU0BCgKj+vP1nNxpmvzn1lPYX+15EXJn9lxWmFjkYhaH5IQ
 OdfC1nsiYVwzi6GNxckxpljn/sejMsc2oqA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98cvfkc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:02:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c0c32f4b1bso36492005ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780840922; x=1781445722;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E544aA3Xdhp2JbSmxDZLkz7HqyAP4q+CpKz42TXJzUI=;
 b=Tw4OkKwZG4J+/f7Y8Qp9cQwjt6ysYc84gELu3HiQo0y13+RbYNdT62B4Kc3IuIlNqM
 FvMKBwUfTQjUjloi0wfPlSqIQdg1j4WGQ/+NsGehanl2KO/ypKFA0YJSZV40MbqQTAwT
 OW1A4SymOQtkjOoh81kAh/tH6ktfkdOj3xYQYhrhl0o4kjQxL8XxGZqhfviSeikCtW4l
 rnaogFIE6ZeUlnYuQUTOk3Iej2ovixKGFEJa9HDFPRMxDPD1Hwc0l8cmUq/PtueA+hsg
 70d0NleYwqhVLVtRzEfmDRvDM4FJCtjowGKOsK9SPio/TVhxYcd4sjhqEmlRjSWQ+8XK
 egOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780840922; x=1781445722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E544aA3Xdhp2JbSmxDZLkz7HqyAP4q+CpKz42TXJzUI=;
 b=ShSoj7qwwgmcToHoRG5tb8/5D/TOhuseNhDXvTNq276xt3N6yVudEvsFiF2PfnTI0y
 1uMBC4XVWi7wDDjowQyz2zDGqc6drVm9q+iSjp9geHlT0QQAQqEHgydjEWikeQnoxsQF
 P8ZrTbMDXi/pB5MXw04KAAMTO7G4IEMpCiQpTmnrvhJE1S5z11n4qb/rTmOq86eLziCO
 n/jL3DMAJtLnE12qvvITApYPuVgLBl+ZkD5vDS6whmgkjcBsbacbeTvTqZNPZ8vjXUZL
 UIESACNPCPLrHDlUtwgISA/awsOsAwzfBLZotU5bCt0WslqMjng5b+I8iOJG/XGSnXD6
 mlkg==
X-Gm-Message-State: AOJu0YxQJyvkSB8yuftSkasfUq4HsrEArnpNgOcJnTjQ84KnI08o88kO
 3GqrVa9dsl3VSExFdvj56Jv7rq1h+42FUXe8qvbGOcT1QUByMKjuRKy3Iu/e2Me23NWei/u2d/5
 Q2IZ22yHZG0XijT0ijooNNXfRS92yo2pMffLEgFZA8KB3R28oqJhirsPBM6OG+bgw85xX9Ca2ja
 2B1VM=
X-Gm-Gg: Acq92OHrWcS/cz8jwTFiaSteCZckzf1sFShPQscnJQYri4dQq3PJyF7mqTDkjiNAhTf
 pk8PsELVQL4gTT77aljnEd0OjD1uMRKJqU3KoRgrBpM/+Z1eGAKHwr61QseW37jlVZPDmafA3ft
 9foYkZRQ0zwiwKGMaB5HkY4Ak99+3zyql66OhORcnmaNtS+f7U6sv4++N29Ez2jQnYS/jFCyi1d
 2aGaZR+iMWWHeJI1y+kKREpOYhMo1CATxZ4TARCcbJuqlQLV2nxl6N9tIhzDzowG9EDkBJxyNr3
 V3Vk6dgfjhKcfkHGO/pKQhfvGJQf7yIRS9jsL8Aqkv33ckTpBBjchc6/OnkqDWOkYjlJ9bRyzaY
 7vdX4wC+pVdd4LCAXTNS1Y2V66wTnn2QDF9ELhb6P6Jo=
X-Received: by 2002:a17:903:138a:b0:2b4:6d92:b002 with SMTP id
 d9443c01a7336-2c1e820e32cmr119002115ad.37.1780840922240; 
 Sun, 07 Jun 2026 07:02:02 -0700 (PDT)
X-Received: by 2002:a17:903:138a:b0:2b4:6d92:b002 with SMTP id
 d9443c01a7336-2c1e820e32cmr119001665ad.37.1780840921724; 
 Sun, 07 Jun 2026 07:02:01 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1663981basm148370375ad.67.2026.06.07.07.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 07:02:01 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 linux-kernel@vger.kernel.org (open list),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/2] drm/msm: A couple lazy-vm fixes
Date: Sun,  7 Jun 2026 07:01:56 -0700
Message-ID: <20260607140159.137068-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDEzOSBTYWx0ZWRfXx12a63qKwBrN
 GKq4RFdC3A1qHPL3yi0QZqva5/eH+8JyAdKOOgZcYi6j9z2Jbnv+2Mukz5vj7tEp2BlbxbeW3yn
 bBa+bU+zr9fzBDOrNN80QczThjyBEhpka0eScm0OCH9OZp0qsxz54kV5r0/HzKxiD7SpU/+8iAT
 t6IMmLR3CKN7aKK4jPmF951xEfngoYJrvtbTUrG+ZQnAahZ85URwFy9HMfQq4AZjU4/D+tTr7TJ
 v5bR20Y+XINvDKLYZ2a4IiDu+q6NntVA59qNe1l7bQADG9zSNo1Y16nugLZufIasA2keRrsn9OB
 uY6fWC/bvID074D7bfLtPe+oBSevDP2hAjNj6XHUTSRa4wK9BKJ4SWo7KH0rLSHYqg+MmNhQ5Sf
 mhsH8MTtDVP+HPoXZ/Cs5ceFIOG72DaO4AcMa+aiTF6C6UB3BeC9wCrOm6CIjSt54y0I+nXjrKE
 +qlyOu6YjrVNqjV/g0w==
X-Proofpoint-ORIG-GUID: hCPDMun6FUbYItAahSyfRdHEadkfU8Fd
X-Proofpoint-GUID: hCPDMun6FUbYItAahSyfRdHEadkfU8Fd
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a2579da cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=384pi0yy4wJ6F0PkkBwA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070139
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

The VM is created lazily to give userspace a chance to opt-in to
VM_BIND.  But Sashiko noticed a couple paths that were not handling
this properly.

Rob Clark (2):
  drm/msm: Validate lazy VM is created in GEM_SUBMIT
  drm/msm: Validate lazy VM in GEM_NEW

 drivers/gpu/drm/msm/msm_gem.c        | 3 ++-
 drivers/gpu/drm/msm/msm_gem_submit.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.54.0

