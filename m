Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97801C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B850B10EBA7;
	Mon, 14 Sep 2026 07:34:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PA2vsX75";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BYTjbQ0Z";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB7910EBA7
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:34:16 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E5jQTn3842847
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bJ0LnXcfs2eCKZrtoDG+orKK
 jrb0m3XGM63JVNK8OTI=; b=PA2vsX75z1gcXpghMbiHotqxgTQDNnDbIsHtHarI
 T7SqbpFbUFX8pXO81QdcRCdey2Ab/gzWuCCBSPDoE07/1yUzVasxgAA+inrPNizL
 trZQCMAIpAomS50ABkai0L8lVVlPq7T3GKTLute9cmz+TrPTlixL1TgjDcMIYDZH
 ejuaCoFEUWLxZsnDES9mlg/qtdsha/m2D9gzlG9NaDDyNFXKHEGPAl9y75nYmn0D
 2cMBHE7XzGOzPVyMufcSGX2OmP4tk1ie84AQPzzfCMM7qy2FZoewgsOysasLj/ez
 BrUXzuRj5x9w1NY6C1yaXZvIJcpBY3ezZpeYVlxGKm8WUw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c5j4q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:34:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a08ff8451so257888585a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789371255; x=1789976055;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bJ0LnXcfs2eCKZrtoDG+orKKjrb0m3XGM63JVNK8OTI=;
 b=BYTjbQ0ZOSRXdMTSfBx09iqa6dtpoR9SDgN3cCu5U4p9b4rZ4pFLN25TeqInci57PY
 04M/Y+9S3TRw5JXHx6VkZpy56fg7yssiR3FwryOGz3nahEi1vOOwltkPuhej+CzARR+K
 MeT5Gw8fKiXu9ci7XVNIsFgmMeCYmLPGm8ykgCZmaFDtgT9seobMA1nAqZ6dDxkd0Nnr
 3a5LBfohgpZDWaFrAWUXerxeDEupiZ1wfX3hVwGFNqf9zin8+ZaxbLHpDXxvCOSl8Jq2
 9AVA8GqsJOIQylyRBR3S4X9OcbiDnPobrFeF+B82UckRJL0CfqUX3SVdUTZEsKQ+BcRK
 ohHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789371255; x=1789976055;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bJ0LnXcfs2eCKZrtoDG+orKKjrb0m3XGM63JVNK8OTI=;
 b=inQ/iRP5sxqbfC1aTfiJIpd/Bpq71svL1jdvQBgpmKWX7Urt/PWcbIdcHOS2pZHk32
 YDAE3ODnyLDmoc9tLejFLnfZLd5lm9v/lYTIIOGLf11OHZAyrwOeKpV2wdnRmISPUII4
 97U+xtGiJShmieafVrd/DUoCkA2w2uULLlCuQ9ZayVB/E/UDX68U0XPRYJRV2tXpq4/g
 UVZu4UNm/IOq7+kwJ2b0Lx2dMtfSmNbF5GmHDX4in7XNWe7vibaeNppZ5WYJyJyCflYW
 QdGgeO7xId6Vr6+Qvwqco2hHs9/PFPdKtoSQvx4dPShUKeiZ92sqY3vcEhr6RK3V5Nil
 tAkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9Ituc7hrwjDEpxCRYkGgWJ+1unGkeqpg6ht/P/ObaHA8iS9t5pVCZInAI9rpbGqCscorB2WOyU7Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n89BlZO79Ekasw08AaNU+Uv6mLLUjJSTrXcDsEuU6WPnI+o0Gf
 0DzS8CndozcjnIE1ZsUw/ib+3nkpneiKE6+2Deobh7DUUeVoZFJEZ5uNk9x9sdebmHPrb+myUey
 xTXh5XTSrmi8u0A4uwmZxFZkvLJK+m7hTvJK5/iTZ4OEpRUos27eSUXEPQGGvZfy/Ht5UuZGQyI
 ta+Rs=
X-Gm-Gg: AYBFou3kw/OAeELGnO43oquxF1O8o4c3TGIX7CWB5SXmfLhJLVKFCxMf8Iv7d7Jpmj3
 W/JIEXzpjmkN3pygxvV9azOvUAEWAT6qOVBUXdrMrWIxKjK8RY0F3ZEjuxQ2eYG6B/DA20Lotc5
 +Safs8gv34umraiRVPdiFZQbgrHsx9vTEtNCpgPWepUnLBpq52mOYEO/gnU2mA9eXYlGlfcb0at
 CdmvnVUhDZ3VWKL6eJq5Z2a+l+HRx7+3BkayLrBJfT+bmlaEaJ5t8+3oUc0EnepNOaxP4XclYB3
 ZXNp08R8snNQOFZAk+31+pRMVYlgzga2ZVeopLHXFBR+YSADEObMCOxxkthOJvl14liTP2+zE2J
 zHe5HoX72CgQneQ==
X-Received: by 2002:a05:620a:1788:b0:939:f27c:7433 with SMTP id
 af79cd13be357-93a29c132f5mr158407685a.50.1789371255023; 
 Mon, 14 Sep 2026 00:34:15 -0700 (PDT)
X-Received: by 2002:a05:620a:1788:b0:939:f27c:7433 with SMTP id
 af79cd13be357-93a29c132f5mr158403485a.50.1789371254520; 
 Mon, 14 Sep 2026 00:34:14 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35f3d9sm24084717f8f.35.2026.09.14.00.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 00:34:13 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:34:11 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mpearson-lenovo@squebb.ca, sibi.sankar@oss.qualcomm.com
Subject: Re: [PATCH 2/4] drm/panel-edp: add CSOT MNE007QB1-1 entry
Message-ID: <biywo5isdeagqu323ozaleeakngl4sngps4v7ngwqo23ju2sw7@jn53hxxuccff>
References: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260913201835.250085-3-srinivas.kandagatla@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913201835.250085-3-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: YFS62QjSEdAjrdR1cY--fa8F-_ii73oN
X-Proofpoint-GUID: YFS62QjSEdAjrdR1cY--fa8F-_ii73oN
X-Authority-Analysis: v=2.4 cv=c5Y+0h9l c=1 sm=1 tr=0 ts=6aa7a377 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=PY3c6-KAFs37oqjDjR4A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDEwNiBTYWx0ZWRfXzWbOXLJE7A0y
 7Q/K42ZJvxgTI5946aMKrsExOp//p0VvVpKDC7jAY6V+tdMtlFTg4u17DRmd+0i/yqH42L5XTtx
 pefgMPD1qzG7l5tDWbSPGQR3BLgmZd+8wQJZriqzo6k6UFzWL5ydCwDigPaotz7MD4N9kiAIjdL
 T1hD5RK/BXspTHN2cafJ0z2LdMSw4Pv2Yuh2pjn0/LBrOFaWcE2SKvQxCpBrGXtHZ3mBJsZ59ek
 8QBfWJ0Ua8eU0Qa+Y/Wxm2Da8eyVtJQD8q3n8nArWfWsmZDulm21c/qDS+RSIRN0Y//xkPimokP
 ov4dnkisQn2Gd3ctxqQruqjiADlPWrrVJhvgMdx4nwiHPA2N1uaB/KkBrjXBxFx4L9uM9qsAArD
 CZTB08Zq+ql5QENxI/ejjMA3NNA/Zx35KLlFgHkHra5+VxfgMhAv5OqZ+cuerCG1U9MNrDrqZti
 Xv9tVmG58jvuNjNQ5xg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDEwNiBTYWx0ZWRfX/JE7wIr9Z7qu
 t8DgHYzI6D/Yr4HjW9Z1qV7iKTNsgHPPA8PYUhbmu58buW2tv82YlARE95bdUVpdyurSeCiUhQR
 Bh97LwJRflOnq5WTUQUajP/HS/eXQuQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140106
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

On 26-09-13 21:18:33, Srinivas Kandagatla wrote:
> 14" 1920x1200 IPS panel used on Lenovo ThinkPad T14s Gen 7 (Mahua).
> Panel identifies as CSW 0x1465 over eDP AUX; uses conservative
> delay_200_500_e50 preset in line with sibling MNE007QB/QS panels.
> 
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

I think Doug starting asking for EDID dump in the commit message.

The rest looks good to me, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
