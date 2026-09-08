Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6020CC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54C510EA70;
	Tue,  8 Sep 2026 07:11:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WGcKJ0ca";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jrne+5B8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA8610EA6F
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:11:10 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886LiKh950259
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 07:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5f4iUpOb3yH3JsFpfvQ0KdsnnuKnbeOttiwhu6PZwtc=; b=WGcKJ0caoM3MNYsI
 kTAtfJAYbYZ7Eywwr4p9/VhHn1ihucM02V/Q1eKF7bxhvo7wVjWFP4Y/5ZkNGcWv
 8U9UhRXBx/XeDfDp147sptkMKZG3rOQufbQLDyj6rRlwG5y/i7QOUYN5ImD+qJzp
 eOLJdf0amU8mKWoB4wCmXH8exhs6+soAY7PaaoQXt3oScaEPmPDqHC6+vY5SA3oE
 wkHMRze+q/VquDCRIQ+Fa2e6Wbq3bvz4eKplzRBa6IGcm9j4OeuPs3/y88rO2wEm
 iHxYf3zkq+AMlBHMobx/U7nzlUnE9S5J+1Us991otwt+6XPh37GB9ewLmlHnSYAB
 o/kCsQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcrp89b7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:11:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e53b8a302so795159485a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788851468; x=1789456268;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5f4iUpOb3yH3JsFpfvQ0KdsnnuKnbeOttiwhu6PZwtc=;
 b=jrne+5B8/PD6hsgqbFTv5PY6782FjQUlHX3SQvBljqocQny4EsnWKQ2CwuVaeWGWQu
 rj3yfQul9yWAoQoM4uoKCoxWXSa1m9B0uoGK4DVgYqcaZCWGt97UWWWoMV2xqbUYkgiW
 CbscWloHpZuINdBEW0L/I6mg6SwKpUmdZhWI3wcbUsH11SBJKFS96FcOkURqYc8JdeK6
 BibEQajL0HpL8lrDI6N+Ff3NyphI4AqhxI4RM29AWet9wxa3aeAGld5RIhCU5rNIKWns
 Eb+l/JK3VvKG96WCPkJQq6fuEtl+NBMpkCc/ajNmkjnVeO7mppispo+27AlfKaUgvhbS
 bLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788851468; x=1789456268;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5f4iUpOb3yH3JsFpfvQ0KdsnnuKnbeOttiwhu6PZwtc=;
 b=kRk3Nmf6GlySmCb4mzL32kwKwu0VL7iBZyDly8nDsciXg+p8LI8n99SH9PRzkNgCM/
 /BI9IL6PQyvakr9kfjrDDV6B/YT88M1nyz2/LIXMUOc/xG4Poy1cZtdIT9wlTO8UIWW/
 QoAuo66VqlHA7vt3/Mi+TZsc2zFdD0aTBEcPDAQ7vopSQfWC//xSiGyItow8OntrjHMS
 4IuxwKYQ64disWyYP7iDfpWDnE4vPaN0E5ADCkf2c5fX6FrwOY2BftFuukM2UnJUqk7W
 pitBQKRcNW9iEdYt5J0Gjz0TTtl5tm2h2q65PW6F3LSshjJpCwY7kyWNWr9OWkQJrXXs
 WUWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOyw1tEXy8W1Yl67MZnaWorpODpm7mx9+NvmAuUelxNsTvvK6U1VztY+9bUaEJKIMx478GJwKQ9/o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kkPYukWijkKJeaasEqHtSk3+rwFMkUVJh5UpUviWVHd/DLp0j9
 ofgs2eA8RW0WH+VyFy8szzJ1fgD6vFxTdk3NdQWnr3uI9P6WES2bkOp5cGu+9z3iwrEvQ+yaJgN
 mko7mFn+DKKXO/lrT3KPRdCLtiNT8fVoJiAu5ThrlL4v4lfKqbP8SHqueWf1Xc7VnzACYDfo=
X-Gm-Gg: AYBFou2ORyI0feOIWCSvDYVN0DJW+vd/kCKXk1OTtlU7U6NATEmpiTLieRbb0FKCN6S
 9TSolmY3qJXJey2Q0G6FXh32wzmbTra3VD050ckRS4OMzaIM9l9aFEgYRRn0WnKmWcYBpBcE8Kl
 fKvMNdW5rVBuwTk1YOIqmN+93iJb+iMlZvAeNwBVh0EGhyRrHkk+dIXAWLAOhoCYCLf+5Ctx8KS
 Ht7aNMgWFmhkZK2Elm0yHog+hiWRVGGgzIS0ryDzf+us96Z2ZIsNEMOYvxi85tXKEvD33wYnyxM
 lhZ8rROsH7XDRPxhOUtAWNF7ul7XNNo4FpuVRBxGI77FIKFyX4LEpVyR3RQe1/opgb3F4OGuoR+
 Q9E0TvwcP23VJdTvWfY0pMSk=
X-Received: by 2002:a05:620a:6413:b0:939:5cd5:e243 with SMTP id
 af79cd13be357-93980324c12mr3025895085a.6.1788851468435; 
 Tue, 08 Sep 2026 00:11:08 -0700 (PDT)
X-Received: by 2002:a05:620a:6413:b0:939:5cd5:e243 with SMTP id
 af79cd13be357-93980324c12mr3025888785a.6.1788851467992; 
 Tue, 08 Sep 2026 00:11:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm453173805e9.1.2026.09.08.00.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 00:11:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 09:10:45 +0200
Subject: [PATCH v3 5/7] drm/msm: Properly handle msm_ioremap() without name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-5-dcf8956878ca@oss.qualcomm.com>
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Wpzp/cK3JYV/8SlC8t8vd470HwV9IihYSTjTRLAsIu0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqn7T7GoYekeeNs936mhSqK6BTQzcjxgH/n/DP4
 3PSvBcLAmKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap+0+wAKCRDBN2bmhouD
 1y4FD/92yv8+hHdjHnG5SA81WkyDML6FYcE9zaxhdIMgyRMN20VVvPLGmh5cuUShIvlbKsq0TzI
 T/b6Rel4LYsz/QtZJB9DcGki+3k1DHDpmiEbqtINZk3dNhqdABLTPi2rCHYg5zkIxsMrkqRcNjo
 vTWdv/fEFpNC7n9dJ75Y1AJiaktcoC+M1Rup9bmEREZvW1tZr/KlCy++WCr8Jtsoz6sYpZz5kYE
 lAUaHlfFX4wc62YvBCalhyctCQMw2PD9Jb/wo9AMLkGNrb/lnj1OzNP3q77oKAuYOflY+G+neZ2
 UqNObT2Is4xuc2WVqtqSMaLRnKtAGEeNMDWj2H5EvJw3U2Wx4WZ9OX372zgSTBnAcy67PS9ybH9
 rRDzT4QnCDLkVjo/5wJkIOw/TILMPymDK/VBd9ZJH77AZxWckUmAWO7zASl2neMk78F3rHZOaYW
 kyuQMR17A8mrJqbYxD+ZUKNKKIfiee+HcBabo94KkSu77Ul8XX2E+rotqFI4dKU0DPwqQNmW1qo
 nGly+iA47fok9w04upya8/OmXgpgyObpaTLxUTJAyqYQnAyGfwx5A8OO4lqHHs39Xfdh+TOJ5H/
 40Yp6xcWuRpphG6oucHjBPUpQPZgBnzWAtr/VhhrpSLMNS85SwRBjVEhcVhbKUJ77L8XusVizD5
 dMPXziW8Ml1jDsQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=UfRhjqSN c=1 sm=1 tr=0 ts=6a9fb50d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=or9nyMeYumr6D7LEzWYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 5qhuzpHdLWuPpgoxEjPuy96c1nAe58Wg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX0ONjRVvwhYhL
 OLn4Hom/7IPgEntx/MvvxsurkdXVTINM1k/2k4ECbg8QMYVA8Q7Rq+MthwzULb2sWaRviPdYrKS
 YFdxiRi4GH9cNCY3+sA/E4qhzCHf7rACYgdapvGEZI+S02ufNE2IgycgI3f38gEVkGbKBMaRpM0
 iG0jz7k3oQ8DB3oYShmd+qXf/L7e3MNbn0taD6Jmxdn7kuahiIZwcvb1m8bTOMafR2ypSGxWPAF
 f7avDbrChOYDqme66IL8ZHqwJlLhrQlZ8C+a/CpGx/TzClhtqd7/Z6rG9YWZ/Aq+/bVONcDXVVu
 bi9sgo7F6AaNVl4AbCziYbQgYg55kjOHVi0cRxLP19rNOxQVScLwa3pZgBw0umnv2Ki4yxnDQEa
 3lyTxX5tNmkNFLnzk5FUNMFrlc2mJMc5cDbBhuQBPUp0C4ZnPueGDKtZLwGRHNmsZtjrTN0UgY+
 NtsMVli5COe9FnU7z0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX44gaIR3d/DYa
 Jpk1woO+5AhmMYHyzHSSyqiRVjs29Q7YMUhc2qBKjxQknK89+z+lMl5YTgJ/VtJLsR4BGWtZtaT
 YVOaVWzoYvwqFDc61AYmsjjwrG9Pneo=
X-Proofpoint-GUID: 5qhuzpHdLWuPpgoxEjPuy96c1nAe58Wg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080072
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

msm_ioremap() accepts being called without name of the region to map and
in such case maps by index 0.  However error paths still use the name in
error message.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_io_utils.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_io_utils.c b/drivers/gpu/drm/msm/msm_io_utils.c
index a6efe1eac271..0a4ac0fc5fb5 100644
--- a/drivers/gpu/drm/msm/msm_io_utils.c
+++ b/drivers/gpu/drm/msm/msm_io_utils.c
@@ -77,7 +77,8 @@ static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name
 
 	if (!res) {
 		if (!quiet)
-			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n", name);
+			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n",
+				      (name ? name : "#0"));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -86,7 +87,8 @@ static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name
 	ptr = devm_ioremap(&pdev->dev, res->start, size);
 	if (!ptr) {
 		if (!quiet)
-			DRM_DEV_ERROR(&pdev->dev, "failed to ioremap: %s\n", name);
+			DRM_DEV_ERROR(&pdev->dev, "failed to ioremap: %s\n",
+				      (name ?: "#0"));
 		return ERR_PTR(-ENOMEM);
 	}
 

-- 
2.53.0

