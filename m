Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DBFC982D9
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 292D010F2C4;
	Fri, 18 Sep 2026 10:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LVtQf1BY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CpEt4y8D";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31AC10F2C0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:22:12 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I9dVA13916152
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=+Cj2ynXc5ThSbdNKXTGycnEgAYTIBHDEBAw
 0L79FsWM=; b=LVtQf1BY1sML0ruTZ1cs+zjOZRkvNdtFNHgqbg7n3JbZB7B8242
 NSBefiFVPjYXEjhkcq6UXa2emm0q7IYsq2vvafzp61AH7Yxsf/7bfRxYfkIe+jhM
 LXLGELTSz+JZ8J+LeEVNASgC9+3DdnsK0x6zd6WXr0ElVAyFtH+p5Fy4BWnxUK2e
 +4K3TzoD17xGcCKlTubabRejH9e8RqAIAuNw4cSTKX+erz/F+s/qzMKqCuYgJm/6
 c3HSScTbWci/RGGfzTUEt580584nfDF56n4D1hgrGC/srHzPJqJXfFLn6j9FCA3J
 vDsaWoMbmN61KgcYPhqo20QFjP1YyQdIANA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grrjdtnju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:22:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5328412a7aaso10943391cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789726926; x=1790331726;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+Cj2ynXc5ThSbdNKXTGycnEgAYTIBHDEBAw0L79FsWM=;
 b=CpEt4y8DBIyzOYW2q+Et1cdU2hVOCNzJSgkob7p9qsSmJfL43RAOiaczo8XlT8xlmp
 4aL9IbArYHT9lUqheMf/uawusgahX7M4kU47OTOkzu5aVrCZRa5tBaWl4RhThzmye988
 egiAA35JJm0x47+OO+CvFn2T12HMdzHou4skqVU1QibZ8zitTOzNozvLyaxey4rssp6Q
 w3O0ool+HkRzNgnuQYZdVM4/ciVB98o+bpL+5d1/KWduUSbLwG/b+DKUkWIZOCkqzlUu
 RrlJuGjSrYQDd+h0mCBXUVJZGllpkbKmqXDYRyHpCZYqwRuB+yW2k5vVB5QY/zB3rer+
 W3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789726926; x=1790331726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+Cj2ynXc5ThSbdNKXTGycnEgAYTIBHDEBAw0L79FsWM=;
 b=eykx7IJehOEiwttA1meVnz8tiEcK/vjoEG78b2yFzxM4ykTgjIZD7lC0pml5GusSRN
 aE6eln40abeCxxa2hRgTI7PdA/h/LH89kSxBRoFmzjZh3FNR6xWRlH8glqu3IxoPP3Hn
 Q+VxgKY4mnsvPQZlI+svKcqjdNmCobfD4L9MtFFEOGzlyE+JFT4XPbIDwfNhCwWB1wpB
 SIjj67IBNteW2JPCFlxrqlVaC+B83w/BPbhKmulOtwTBGfW3mAlxQkkHbwFd+Lr7r7EV
 fixUb+ZFK2M5JbUp7U2muQadCdESYVY9UjLb/ZQae/y+i3YFbGAn5TOw6x3KETkZTpU9
 SGwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjOFdrFPxmEqOIR4KMLhUOw4GPbaGx5INweSN+ibPgz18itR0IfCIufPWMuSBHEpAgIuImKzLfVGs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kS90u1fyvnLl9QnRJOIrjMyMYTaiuGQgRqlsV9VknGbCDQbhjO
 NQnYqWFptuSgY/+TRph0deTInztQbqXPHmTKawOqFX6yc3d0E1ZiWG0rKllbV32fd1VVuKBE6pt
 MRg64VsqAhj6fw4lO+WiIj7CmpWcYr+aTGDtTv8w6OcXOm35W3IJq0VlXz3nxZkU1tp6dxWQ=
X-Gm-Gg: AYBFou1uOCZjJ0nl3JV1K8WLjo31iSy6AxsDPOpxeOCU4QFVLFifsY3gKmQjOqHsF/v
 LIAmdwZI1bvTgSBXQG1TnxK9anKlJR8sMfVzR6TvQ7X/ptlk49KTr40dpBE1G0B9p5O48fr9S+w
 vbWh3qZ5FmeedVM3KkanEnvRESR5YFP1PQEk+K4YND5/NG6Vxj2bag44Ry81LGtNpNIGWhsOBFE
 twgn1BQsmf9pvlJNkDGPogIktgAi6hdcDLo13BaVZDOe4jVf+hG9tb778xJi5TKojBzmQS8pOVC
 1BoHM7/5RdOab3q6wG65PWxJ92koPjun7pAG5mcNcCfmBQtaIN0/cvGWOZebJxQBNdvEGT2jnv/
 JtnIWzbgVB3Z/kiA=
X-Received: by 2002:a05:620a:288e:b0:93b:d7b5:8a30 with SMTP id
 af79cd13be357-93bdca7aa0cmr263499385a.86.1789726926192; 
 Fri, 18 Sep 2026 03:22:06 -0700 (PDT)
X-Received: by 2002:a05:620a:288e:b0:93b:d7b5:8a30 with SMTP id
 af79cd13be357-93bdca7aa0cmr263495585a.86.1789726925737; 
 Fri, 18 Sep 2026 03:22:05 -0700 (PDT)
Received: from quoll ([178.197.219.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008fe3csm2984300f8f.37.2026.09.18.03.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:22:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: LiangCheng Wang <zaq14760@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] drm/tiny: pixpaper: Unify spi_device_id table style
Date: Fri, 18 Sep 2026 12:21:58 +0200
Message-ID: <20260918102157.78605-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013;
 i=krzysztof.kozlowski@oss.qualcomm.com; 
 h=from:subject; bh=5wK9/6OJBIorpDnueUEKkoBn8G72ZnSkm2xTJcs0Wqo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqrRDFroFllx9nUyQxX3qbYXLD1BsyXrAOQ5E4V
 WK1jlGaEkGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaq0QxQAKCRDBN2bmhouD
 1x5GD/0ZU+BiUSbL0EhDGqJ8k69/D+Ju7GVNEnl5IUCXFqBB51Gr4ZiQLvQdKVIKhpmLO+IG9c/
 q/1XOtQde8duCNISvMPjUVNLHLXh/SJnDsNUIaI0BivK1H6lN4cvzHmrB5l9mwXFqb04n7mztfB
 DTN8P9NJ0koYKNjAG8lqpwQELzu7xTjfb+Rpiw4kOtSbaoPTn8uV0UrIssMBZHMvVUBYa/IcsPk
 bIGkntJ66EFych7kWP4Q0i3XyZNjl6mJDCRtjt/qv6YVKFE1rO0y6lZifV4fx8Qv68GZ/in6aNp
 EKYLvDf6wxyaav7GUugZKuz0EKcnn9zr0qsncNCA75jCBc+k5RRnHR3arnnnt6qed2Nd8poImus
 j5gh0dIDP3L1QBhuprHTnZdfKAEkfvF2f2QW8CLWHxI98V3GuxaedLTiRyRx8qKq3btuuuHCnrs
 3LKk8uguhtaQN4B4NcqaI9YWYo659FSUZb//9lfI7Wf2bXTNg329tor4wzYuUOrR1QzdOSS1NKd
 pf2WCqgU1XWqgmyvcnGdDq4+z5x4WeLyf+iSPf96gBZQmMQV5kGtP2+5EBZoIkjs0WUvsRNYeD/
 hkj/dYBbERArkQSYLnrHQiWGxQ0NpHa+LAZsVaR+kKnQ4X+NQS2MS7hhJh1U82YIvCAtWt7yTOb
 gzU6ZDEYxH6o/qQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE0MiBTYWx0ZWRfXz/4Ijex/w9Th
 esNppLV76MIQDPQdI6SkKlAAA32ARmcuLPK40G0u06RrtAEmR88lp2IK9/jpW118adI2W0vH0lZ
 bGy9EUl0Mgxt2hmBI8A7WI2ulLe4O/CuuulXJFOk3fiN0eUKwYWGX169Xh7Bzhn1X/uAXB2r9MG
 uNQxVcaDl08LrlA0T9x4gaWOGQj4C7+k1HLOxuiv7D5SarfFC78kI1ZmMWbo7iDwD7vydnxo9yT
 QkQxgB0NKDkmSqD/2XGhlZKPFR1aFPHsJW6/JxAgdPJk8X4X07SCgNk0pP7o+nMXI7CFEpwq07l
 TB11982VeMvSVfOvqL45PdfZ3STfH2tIcNSxWvbb4LKICjtTHs48g3K6+frCf9mGkMVYTgED0aN
 m8KjBJH62LZ2g+7BwQ5F5xH1EoLy2ea4/fMbAzihJE7KKDzb2dm55jVUxmtBYZdaT2+0s5fqc02
 /TGgRTLu1lveAMuvh1w==
X-Proofpoint-ORIG-GUID: IDZFkpuzzAscYgtsU6BZtwVePusgx7D6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE0MiBTYWx0ZWRfXyqsF7SCU9+oG
 dHm3XMfcqwzV8df3BMhU9bOP5jrFodBdrOqbu+P8JM0kbYRgsASaOseDp9OkRtYjHL/7QPlEf3W
 C1QFw8sWcL5K2tIPM8FbKN3MJ94tiyA=
X-Authority-Analysis: v=2.4 cv=J9Q/fwnS c=1 sm=1 tr=0 ts=6aad10d4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=vWZT_hTR9kbyvn0ntK4A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: IDZFkpuzzAscYgtsU6BZtwVePusgx7D6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180142
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

Common style of all xxx_device_id tables is one device entry per line,
to make reading and grepping easier.  Unify the style with the rest of
the Linux kernel, while also adding recently encouraged named
initializer.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/pixpaper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
index b69e7c30607e..ce77c92c8524 100644
--- a/drivers/gpu/drm/tiny/pixpaper.c
+++ b/drivers/gpu/drm/tiny/pixpaper.c
@@ -1140,7 +1140,10 @@ static void pixpaper_remove(struct spi_device *spi)
 	drm_atomic_helper_shutdown(&panel->drm);
 }
 
-static const struct spi_device_id pixpaper_ids[] = { { "pixpaper", 0 }, {} };
+static const struct spi_device_id pixpaper_ids[] = {
+	{ .name = "pixpaper" },
+	{ }
+};
 MODULE_DEVICE_TABLE(spi, pixpaper_ids);
 
 static const struct of_device_id pixpaper_dt_ids[] = {
-- 
2.53.0

