Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9313AC55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26B610EEFC;
	Thu, 30 Jul 2026 13:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="biynfppf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WVl+eINi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7441310EEF9
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:05:26 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UA2tHK736235
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=8Bl+HlaMrwZW23yvXw3JeP
 7hrcrAi/gDsI8dvDZb7cw=; b=biynfppfH50unacrr/1nysTRaPaEaVX1PcuNzW
 C9fwWLKsDCZhwzQyMuS0QRxO6qDt7iKXs5AUCGgg5bGgzFfBtyNTYkFP5gO2yvOH
 HOmTJmJzs/rtYlRQPKM3dzC5CTVbPKP9uexuXzaF9z/BDQeHMtDEGrZv18lA68Ej
 QNFfSzahhlAlBxFZY8+3CW5mZ8Gk/v0OYo7ZQVgwXcmibd2BvNaPanjFGvd5ZBXd
 +rh2XQg0euaIlwmz7kWIjsHENYyl43Qz1z8yPMAxQ5bfaRZEYhAy7gRgx+8YVAN4
 orWyVh/M83tOdy12RUO2Cx3LC5aJd7ob1ah/zK+mVbkJ1eyA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr4a2gt6h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:05:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-930f5da3467so248208585a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785416724; x=1786021524;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8Bl+HlaMrwZW23yvXw3JeP7hrcrAi/gDsI8dvDZb7cw=;
 b=WVl+eINiUmkeMokmMuC+o5lKgDSKxJ08OJN25B6Pw7Zkc6TiqBNUkHOfuE7mFvV7bu
 SZ6olfTiSvz6iGGpHUvls+ALh7lOw0lMqr5J+Kk94OJnYdCwGstqy6YwrbsUAkVbqw/8
 gUfBOaH/SvSoZ78BhmQQrJJnZeBbspOWUtOLPOEuQgGqJHwDp7H8fqneV97WQFwkf0Iu
 DXZTPudEmJmw3BfzUvcfY/i4P0nD/YqxZwHan1acBqfIGnCd3lVZ8LvwT9rWBoeA06Y3
 en09d75YAR9ZUQ/TxyKzqECA4HE9zQBA7/I8liDnHjeNjV1n0iQA7/EkhtoymVT+AY7C
 Jqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785416724; x=1786021524;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8Bl+HlaMrwZW23yvXw3JeP7hrcrAi/gDsI8dvDZb7cw=;
 b=qLkqWt+AFndJz/P6yGUVOJX5ra9jWNufgeqBgZM6mrk3P1YZZ+Akgd/w/wajvkilTv
 Cxu/aYAIPkQ7kpKfPcbkVCpUnQuOI24YUjuFEP//GbF/SxqlP67Kuz8CAQ1wgrw5AM9D
 m6OmE/l5WW/4MUSUrVzbqfaVfGMuCfKkbP0GILvKCTWFnLu4vZJYnxGz//2Oi7Gtrsy9
 IsM9QTizyX7ll2/ncLwV4Z4/fqwWDvd97jSJSB07/l4koC9sxSEj6UB3EroqrMJY66vS
 Mj5Ume5mnW4plHCBFHxY0DwweS622I4mb8IXfMh3i4sah2j35JLqOA16uod+bi/z7K29
 l2LQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAawrmEgzlrdgDYRv4UryEMkbbawUxJ1o++S25qLJRIv31Jkz7sFov6iVivnk35s602qHFquQlJRM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylElAwVVmY4L7S7UOJKgx+5rAnjxuybInbKnO9TDbG4Kn/5aiM
 EMxx5ARcCqZzXiRQqDc3owNVWzUHR9uoHHsNFIpaPA1wpAZONh6Hr/1HOpWwXyKMSUPpyYxsibu
 CT7m/ccth3X59a9FmJG9E75gzWzWaiu+CqtizdSWSIl7tcgeeh5WWYL8D2sfvjvGvh/sAvFE=
X-Gm-Gg: AR+sD12XQCqtrDyWhbeY5mLuZGg3R+8fU91lLNix7xoCupjv4r51/hv8kvp0GgwOLe8
 Mmd+g4FEGlbp+prH8o2E6u1jtNzgwexERYCxoLsEVU68GwZCayZiAr/e9teaW88qWARcFeY8hND
 6azUsdMf/8271bQNSjLUdG8sJMQUZ07c7z57hVeeQ45kXZVSanGEEsXEgkZyoFe62eRHZnDIqVn
 Jqb2Ob087KGIQOpJw+qEp4mZ+Ht0ktObxLhqgppJXAMgadpNEuHV575yzUCkx+Raw34+A94ULyW
 /WFZMf1csp6nDzLss1t7n8IAPVDETRoVe+fVKk5xMsQ68u73Qq6n2qzbVhfs+l50Bj+u7X/l9VC
 tVbZ1EBtYGz3rfRckvsWVy+IM+d8byBgwY8k3qGGV3jLR30VRksch0LV4cAD8QyZggGukuNlQC0
 EeRqyA80yEbiXYfQ==
X-Received: by 2002:ac8:7c48:0:b0:51c:7b12:5ffa with SMTP id
 d75a77b69052e-52b387c930dmr24397051cf.86.1785416719446; 
 Thu, 30 Jul 2026 06:05:19 -0700 (PDT)
X-Received: by 2002:ac8:7c48:0:b0:51c:7b12:5ffa with SMTP id
 d75a77b69052e-52b387c930dmr24393901cf.86.1785416716736; 
 Thu, 30 Jul 2026 06:05:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2db9fec8esm324245e87.79.2026.07.30.06.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:05:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 16:05:13 +0300
Subject: [PATCH] drm/msm: mark the fbdev framebuffer as system memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-drm-msm-fbinfo-virt-v1-1-a27099a6dc58@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAhMa2oC/yXMQQqDMBBA0avIrDsQjWj1KsWF0YkdIVFmVAri3
 ZvW5Vv8f4KSMCm02QlCBysvMSF/ZDC8+zgR8pgMhSkqU1uDowQMGtA7jn7Bg2XDpmq8c09bl6W
 FVK5Cnj//66u7rbubadh+K7iuL8u48lV3AAAA
X-Change-ID: 20260730-drm-msm-fbinfo-virt-969fbb837443
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ikByuc16etS2lKV4CPKR2P/3irvgBquufmeW4k1/Q4U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqa0wJVfCfzqIAaBUMp3/UF8agWYARbuk/TzOv2
 s0eVn2eYB6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamtMCQAKCRCLPIo+Aiko
 1b4FB/4suc6wPPoKhfU2kMLMbnFgSxnwHmUnATa+jVY2TTTP29kQQYSJdygZzSJlJwh6uYI7FO2
 JV+/58iN0LCHFrXz5pkgRTyW3xvE4EofZ7pCY2GJP9xtqrknQZTR5NMVSwRY5TiYg4fzMlKo90x
 XLY9FBCwT9G2nbsalkxzz3SU5xlV/XiEWj9KQ7EKBZKUFC0l0UbfVo2Evw2RcCZ9qUKgSi8NTWM
 Ri/Vy/1vPmTpvtapzRSnAmVF5UnXdr9kCWb26E/oPCE6lg37NM1oZjdFt5LDPZ10ka6l52swyFM
 zC5G2cjOLBU1Q9awIOD9r8svuWhI28KvjkOuIXRdgzRtXoNl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: SmpIPvEceg4r4zB9EZhgLUIeFQj2x6xc
X-Proofpoint-ORIG-GUID: SmpIPvEceg4r4zB9EZhgLUIeFQj2x6xc
X-Authority-Analysis: v=2.4 cv=IoIutr/g c=1 sm=1 tr=0 ts=6a6b4c14 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=QQgrQWe_eaANyySby9wA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5OCBTYWx0ZWRfX0XKy8uPlwskN
 TkHIWZJXHt3wHktRCVDzGEq2v0Q8t52w6xp+lCgFE6W8kZD+PoS/sCE4mY6NjT+MbLRq0+aGf1b
 4KuiT+d3EcoX/CL53CRHPQehK4KHVUNsrka5L3iOa2UAYXHtU/2Wlaamme4t0F6srI7nI2eGcc7
 WlWwJ66e/J79jfadsqCsHHb+XOaL/qpIHhuN81F7/yJ5giYPBL4wQF7yir/0br6wC7JO83UFpud
 ZW6UxvgP9WjpxVQGozV6fSB9NyO+vuCfrRldkOmEvTiCf8NCwdy5rrSgm6BWjXmgO4UCbyx043H
 itA/O1Vf3uGrhTcLvhUM+W3n7e1qvtMVKI9gsTUnW4dSg8lTUJ6BeahFczgMDO+Ml3HgCckIOtV
 tF6E7ulcFT4YiTl1rT8eUtbTBJAPl9F7fdb+/d3oU7VI+5reCAplAbbYsRiH0Ue5l+c4B+/zAM9
 6wZDnKOoO+q1CuvC1VQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5OCBTYWx0ZWRfX043Dog8wOfLG
 9XWW3whA6NlewMng4p0DOGs/f/VfHV6R1jfSRddFgFfFleyjGav9FKIPNoUxj4ADXkp+DytGjUp
 Juty5QFz8NhL7tqnB3SQ3aMTp/c2aZw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300098
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

msm_fbdev_driver_fbdev_probe() points screen_buffer at a kernel virtual
mapping of the GEM object and uses the deferred sysmem fb ops, but never
sets FBINFO_VIRTFB. The framebuffer core then assumes the memory is not
in the virtual address space and warns on the first console draw:

  fb0: sys_fillrect: framebuffer is not in virtual address space.

The drm_fbdev_dma, drm_fbdev_shmem and drm_fbdev_ttm helpers all set the
flag for system memory. Do the same here.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/gpu/drm/msm/msm_fbdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index fd19995b12b5..0089301f80f3 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -132,6 +132,7 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	helper->fb = fb;
 
 	fbi->fbops = &msm_fb_ops;
+	fbi->flags |= FBINFO_VIRTFB; /* system memory */
 
 	drm_fb_helper_fill_info(fbi, helper, sizes);
 

---
base-commit: 3652b49adac266a3d27cb41cdfdb7d8790fc3633
change-id: 20260730-drm-msm-fbinfo-virt-969fbb837443

Best regards,
--  
With best wishes
Dmitry

