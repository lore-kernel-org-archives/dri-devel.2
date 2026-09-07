Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3390DC79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E89810E7F3;
	Mon,  7 Sep 2026 13:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UB+lkARR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KjdMKwH6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646B910E7ED
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:00:40 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AvTFq496381
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ywUruZg+R8a1lUYV8BGnIItve+PwkWpsyPFMDteRsLk=; b=UB+lkARREkDBMKC0
 NviQrMGhrf6qxwQ0kJkpeGOK0gyFBtu5bEZB80GNB99VMGPpr0d/zCRJ6gVPycD6
 dd2zUFwXYd+FgzEcd5zQ3KfOPc0uAMl+kdZ3BF3aMaJK9pbcnKIiUCxnDhvWKQ2c
 FsNO3y0stzSUe30zxk/z0JyG1j8N+Jefe31DeqHKJZZtF+zMcGCzkJIlbSrNLx4h
 dVklD1Yh19CImWCqB6MQiggJKerJIDwD+fB7kV/JfE7J93Btyr+PEoJFhiDL7aN3
 CNGvDBtCN7HCwCfouC+H3PQ1OKQtigVcymAzY6VeVZw+CuGmOo2G9m8pdYgkNJ9g
 Gt3cRw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuyk8d6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:00:39 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-785b66a7017so815706137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788786039; x=1789390839;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ywUruZg+R8a1lUYV8BGnIItve+PwkWpsyPFMDteRsLk=;
 b=KjdMKwH6XKcGWX6WtztcevfGPg8rdPxLv98eyPeiL7pYCph8NbEJudzJUDeRhoIrbw
 lF92cgL1qkzDwP28nMcjKbNT8GEvvyUMKmJfQ7QoKOytKEUacXP5CshKKu0PW3lzoSTf
 NxF9crCcypS8nnXLzdLeG2zRe/C6nOhNSqGHB+rVlEYwg6gOoO/jrP3FMHA7amRsvH25
 2fF2sLdOr808bxScLmGxrrNgMZkZ1M4OnELWg5qvKRykw5AtRh64/3JNcntEFvfRQDD+
 PMPEm28SX7TOqprkzPutPKrH5Us38r8rEMkAxKs8Fljddm3nishrDLaDjf/iwcTVosh4
 4T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786039; x=1789390839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ywUruZg+R8a1lUYV8BGnIItve+PwkWpsyPFMDteRsLk=;
 b=g6bRDUFJN2N8dnYHMqtVycwWWWZJuOdy3Zze12PwI53s4OZ/9Zwr231B3cKpSYFfQn
 BCcEZzaD5+oRHR3O3q+eVQ/O03TV6nMJV9a56jKu/VMDjQLew2AABInJ2R1CR856KRZi
 w6mJ7vZoKwTNX8DF2HF/9RokUhEUYppD32ZFsBD6eHekKPgOnHPrv93AUDxvhIw26Cok
 QpCWNqTUAJr2i4XDw4JsaiEWvym9pWd9jLeQicpVWGBKYSPn81qem013oSINdQmuwlHU
 NAn/6x/DwyMGTKb17MPkl+uKSyhZMi0oM1YDZSNlMKn5IZ9+RAy09c4n0ECUe4Ku3T5e
 jtUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz553oy4JllAOA40m8ntJ6t9vKi0cYoVMTNurF7CKBDFthgaK5kRFnHcgwBmkHMB9s/iZPI5V1eENQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mQXmbgjbYtyLAbPZ29bCQVdGhzye5rsOBKQFxEpweDRc3QU4FN
 +VFkdQOWtNBR3jzzHiDEOicKRA+9zoOLG4E5Imnaam7BZBzQf1gntvqTk8IKDwhvKIfg5IAEwAh
 9HRCGT79VprAUTMR6BFSwysXUwpe0NagpymVBwRZIPcNKcx+z1wSK+nIdUUcj5pj7VbQonA4=
X-Gm-Gg: AYBFou0k2VwfXR6T/mu6IM7V45wH8h6t/Y1V9IrRJOmSwUMe6Q5unXRTITunxuVbnqD
 2riXfLOMr8x8BEus1P7o+n0d6JxwmO7u3PzZVJWbFPq0Q8neegebEzIlF5HolbztJ8+J0rIOEBb
 22TK+AsTrvEyaOIf34GsFNyOiACl9maKz4SlyY4BKwFf41cpknQ10thY730B8kN51JlmjXy4IpR
 G8jjk8FNISMk4wUEQqvh6dhxtK3sXMiXhJDJR6slfPvNS+zKj1QBjEyrvwQPbKu9aQInLIbB5FN
 QmZrMabS3wKIOQmhe7Fhm93qXAUD7eF1xCi+3CQPWYTGrCX/DqR2vx0KMfZcjjbn8zOqZ2hvqRX
 +PG1bhEcBmnb2rWY5WHL/Xf0=
X-Received: by 2002:a05:6102:8093:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-78a4a42c1a5mr7069246137.0.1788786039010; 
 Mon, 07 Sep 2026 06:00:39 -0700 (PDT)
X-Received: by 2002:a05:6102:8093:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-78a4a42c1a5mr7069209137.0.1788786038488; 
 Mon, 07 Sep 2026 06:00:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff81c9b5sm198751205e9.4.2026.09.07.06.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:00:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 15:00:17 +0200
Subject: [PATCH v2 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio cleanup
 order in post_disable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-3-b097cf1eac77@oss.qualcomm.com>
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
In-Reply-To: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
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
 devicetree@vger.kernel.org, stable@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yhhU2Xo1HHomz5Uesadm2LHNkZ1Ed1iZL1EHcx6SGho=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqnrVm9n6dtVYfAPmpBWbc0P+7KtDPbjgKRiO2g
 f4xFQpu2UKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap61ZgAKCRDBN2bmhouD
 1765D/9gKq/3TyVo1ZvMaJQhsBKEKzFGivfDq9Tvk5dBvKhTnupclkca5zjjzVs2+6xsrH+ebOc
 UaKECIR8jCV8y4oLCYPrBb04t5QEuywEKLav4f8RuzYc1psWyNlISEKFLf1MQI5tlLStM11UTvV
 gUhfCfCC5R2osFIct+5xQeJswYXOYOXXxkjr0A+elhiW3yNyM0e/GeYg93Y0if1K7bU0TQvnteU
 WZS1hR2UuDsqqmYrzkxAM9S1G+slI29BNbjIpaQ944nEaatkS3O+V9yAeihjw8o4HUMDbd8q1ri
 eCqRs4RZrMxC4Og5PzhjG68Jo00Ank1cvyfhYOVKaXZB2tHg+iOg7plTlh4c7t/0SGLR5EJy1aA
 xrlWghOna8gaVdvphL6SoXVWxSNQcUpckkoTFssePYtiysub7yo5T6YNT5vPEuOyhFQRyP/owuy
 15FdgKApFnqNg/Fi/YUvl/NJHJ9nqWBPo6J7crUTH3KBnttP7QBEl+HdGWz9pTGhLGzbMEi5hzY
 z81bTiM0Zc9WhxB5ylU9jEZ09iFlJDJ2a6e+dgCwNiHP+IWwgG8gsaY/7Y0IwxgRb97N+TYwRvN
 HTYZ/lwQelPeuZoRkg6X+iskdnFRfUe3EQZMImT87AuS+6G47b17BXHjnOR036Xj5Z9EPvxMrw2
 zBfJY2CFdIPJWUw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX6Bv3otCOtK+0
 WGOr9FRYXs59oR7bDk0diaZWMXbW3DNO30THRRpv6R43I22M3UDPFLvS0d9KqjyykH+VMiY2FWp
 VxuJCwiFJ+MApiGKimDqFbBrqgsqD9M=
X-Proofpoint-GUID: e84RvoKke3bm9k_Z8fC2V8tuNhV2m72s
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9eb577 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ksbDLleXNvo7xJVorFEA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: e84RvoKke3bm9k_Z8fC2V8tuNhV2m72s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX6tlfgC9NqLCu
 16VvHnlDLTcohucVVgkc0nNs4Tgx3VXDRb7BYLD0qTE4Ta4woQtuRLYKZdZMcMO/CG2Z9mqs3S1
 Fp0DmzKYTgTouW5Ijst6iX0pFr+uDIwJRbtfgkqHyGd7r67FJBpOyEa3OANHo7SerdhxZnpq54A
 XcU7lAAp2QRFlH10GRD3oB5UXQSTqJYWeBpfWf4X+tBbwgV0Dby5aC4WN+2cPXDvdyPafHr5prn
 RnPosLuB6vgnDrux6kLSGZr0vjq8b+jzJJRwsv5qSuouk2R07IP0TcCgM1Z2M2wA+AYUyTegvWe
 fL7AcYxXF7SXInlKtWfYXOuuBumlLdrmq95tc9iBylzokiREwn01Oq8lHg+xYcrAxrqTbVLlQ7u
 ibqdultcTjzWYEhxrnzWnq7ZHxDlJFXsH3XPJTASHLXNs7doZBG/Jv3ytXS3H62m1Ynx0JcAcj/
 Ca9qWa+koNKvEJCVt8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070143
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

Turning off the power in msm_hdmi_bridge_atomic_post_disable() should
follow reverse order of powering up, not only because it is logical, but
also because msm_hdmi_audio_update() accesses registers thus block
should still be powered on.

Depending on specific timing, existing code could have accesses to MMIO
of powered off block.

Cc: <stable@vger.kernel.org>
Fixes: c0c0d9eeeb8d ("drm/msm: hdmi audio support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index db85400e574e..04c893062dbd 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -339,10 +339,10 @@ static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	msm_hdmi_phy_powerdown(phy);
 
 	if (hdmi->power_on) {
-		power_off(bridge);
-		hdmi->power_on = false;
 		if (hdmi->connector->display_info.is_hdmi)
 			msm_hdmi_audio_update(hdmi);
+		power_off(bridge);
+		hdmi->power_on = false;
 		msm_hdmi_phy_resource_disable(phy);
 	}
 	mutex_unlock(&hdmi->state_mutex);

-- 
2.53.0

