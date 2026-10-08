Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3613CA6013
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 22:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2556610E450;
	Thu,  8 Oct 2026 22:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mqrc8TwM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aFNI26/K";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACD2610E450
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 22:46:37 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0NVk3386994
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 22:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4EGqHukNt5V7Y76f6G9i3/IwoGjUVi0GuztY4nSPuAQ=; b=mqrc8TwMhoJE2j+/
 7Cu9dWE8NeLSat2Eu6H7ULzcXbc7R5lVI7MV8Uro1BiS/s9jyTla3VR2lgSzEwRw
 bdt/8Xt16rMWkFyidQhEIdaIHg9Sh8q7O2Fc6KyB2im+zGYeuGFCBMhl+XjwZG7F
 ek7Lfb9rHG388asSnKw7cNrXQrgxDslV9nai+5lWONP1bId3qHoilHlktY6bTTQa
 bCUzAPBSv57dti4B0mQHlF348S8xH8R+3jlTyARTMRe0U7I6M/ySldkajLCn51hY
 p2SO0ILRCfdjVQHEZJUi6cDK0sQG9fm+Krpdeap41H8Fe5yNVmEX/mvBhXGmxSPh
 aJjMtg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrrxmv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 22:46:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934956beec8so1244329785a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791499596; x=1792104396;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4EGqHukNt5V7Y76f6G9i3/IwoGjUVi0GuztY4nSPuAQ=;
 b=aFNI26/KsnZ0oj+/qJArmPebXIp1YrdK37WiGpMRhTc+FVfA1PIeWW7fY5xBBm9lvo
 jzWCX5haO67w7CNhrGB1QcSBJWvgmbmg1tadg+hQ206V0NQXigP92kHapu0Lb4muKfEf
 VY3hSlYS+ZWXvNcY2XvKFE6EjNgTBoQT7wBU+lx/s822I6PMewZNYLoexCUxTH0W4qhG
 7ZqfLoKveTo3nwWA04pj5MidV/qRDWj4s9kenvXplYZJ3Mtyx9n0UbjdSP8R2smrB8g1
 SjoGy+BRdui9P8KuP9kkXG0MGLZlOKZb05x4cxMLVd2803//HGXugyGa1CsYzRrXLXq0
 ZKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791499596; x=1792104396;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4EGqHukNt5V7Y76f6G9i3/IwoGjUVi0GuztY4nSPuAQ=;
 b=Y+9T1VT20zgkkEKCEbH2HTh2saqHe7l3eJ1s17WE0XH4jomum7UBKsSCfNgk902fl5
 VkP6RZOLXOfokiE3S8fjnshfKx3ZXBqN/auGSV81/wvtwGeMGB7pQsHRguk8l7SlDp93
 uu5I5Tun3aqxxtqMkwxJLOCzsde8UDnYoOp8J5/xwREIxOJ+0/Bw82+tC0wUF7fAL5Yv
 8Ur6IMPv/pORH9i+M3gIgqVBGoEW8GhkFLtOTeZjjikJwp+w0QYPNr5biaMSEwEcU2J+
 Mo5N6Lii4im6aQzMGQUDGsq3GgJIJgPNnDD6STeAZbk/b67vFZ1m1/ptDXWIw1pnG96S
 FUdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4FgBd0djoSvn2Nl7youEid3FfzqkEYTDCkE2PCng7dH5cTjvioKGUz+GnGPoKkVYv9wFewL4dOf4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n6neFmoQSO40Y6KG4y2sASU5MCJICgE0e6YD/wL0VPBfjpv09t
 8Y577Gysg1me3FXFugfEBuYBXlI4epfaVbqAhMgAntNGvDU+ZjU13d/OBt0ryc/w58k1H8vDbUj
 CbB1SHnSwJzi9TDxkCfNXdv9H0TBQIuiB1RKlBMY5tF2fNQ5SYwXDPYtmlsYHnAIO8g5ceHw=
X-Gm-Gg: AYBFou2tKe0NQzYlmfQ8cxNLITLq23g7myCaH2769gvqJUcdH99HU7FU0rfPlxTsWjR
 tox246dfYLXjjTQtjuHr+YKSI0mJchkIoC1xU10NJ9nGD6llZyferKGQY0Vlg5zzQAwPCNT0kgb
 sRYmTU6+d49STTz7It0tlkKOxWvY4meGts3fZRNKtL8DkzuUT0PbN4wESOnAlCZxMJAvXDWkTz0
 9eqxbMXMmRVnY1tZ4Dy8Bo0xtumyk/nEYfm813KqqXsL3LAfsQmdkOaPldFDzMvQgKw4Q7EZG4K
 RhSzWlmWPhCo6eznM2gHex6YHTFq9xarZ6gjRX7smaHg+nAyy1n4nNCBbySPdDR5bSXBXm7Hs5v
 cbLtp3lyAuxU0c9tU/BgxQbjRCZQn2C92tqfuLRUvxewziJxQeU8GmGBfX10rhhq/Ozv8q9mBKC
 zrT5SQJZrC321T
X-Received: by 2002:a05:620a:6606:b0:93c:5958:9de9 with SMTP id
 af79cd13be357-93ebd24d6f1mr9897585a.33.1791499595889; 
 Thu, 08 Oct 2026 15:46:35 -0700 (PDT)
X-Received: by 2002:a05:620a:6606:b0:93c:5958:9de9 with SMTP id
 af79cd13be357-93ebd24d6f1mr9894685a.33.1791499595402; 
 Thu, 08 Oct 2026 15:46:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3befebcsm1390371fa.1.2026.10.08.15.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 15:46:34 -0700 (PDT)
Date: Fri, 9 Oct 2026 01:46:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: me@dawidwrobel.com
Cc: Jianhua Lu <lujianhua000@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm8250: add device tree for the
 Xiaomi Mi Pad 5 Pro 5G
Message-ID: <6bi4ywt45f6lhyvxkbp7vtzxtoxxlorwhnwizooz5jysubr7sa@krybqpl7e5m7>
References: <20260908-sm8250-xiaomi-enuma-v3-0-0198c3bf954a@dawidwrobel.com>
 <20260908-sm8250-xiaomi-enuma-v3-3-0198c3bf954a@dawidwrobel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908-sm8250-xiaomi-enuma-v3-3-0198c3bf954a@dawidwrobel.com>
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac81d4c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=VoYNWTs0KIJBnnxc:21 a=xqWC_Br6kY4A:10
 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=br21HGidAAAA:8 a=EUspDBNiAAAA:8 a=16WXXSGXZCMmNkSL7LsA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=rq5_1Q1BYlbxkLLkNd_B:22
X-Proofpoint-GUID: it9zfOZyyVABSwrwBZ6i54vGbHVbms5t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA5MCBTYWx0ZWRfX4IpRpJdqM/yy
 2Ij1atWj5arrODbnU8QqvIloGEpGAvkeRPw/FQLFLYk6ZKu2h6pNR94PnJ9dVy1yDFTKUTHVANj
 pHLEfFFQo+bsQ5TlPWkLWRtORNvTO69aR1rmKLceJ6iFOM9ARQ37b1IIyCjD7fBwnAJ3mTQB35B
 mVLTrKnYG/jRWHjTJ2tmdqfWisMM+LTYv10xZL5fgutyZxPKbp8MPBSvZD5VqHuIH7nHOVK/v5i
 Jucv8A8wcVIRz3exKDcQtgca7T4wG6uJZ2nLoNXFWeXSDHQkaw4WwEaxKociWbmjl1Ti1yEZDLv
 D60LKdc5FYQn9wG1lkruQ24zxRTrNC1hqiLqm3gMQVIY7DkFhUj7KaCDXFhICk83ujcUXsHrJ+F
 jdbV2l/W2OSbKhw1GzyPtSo9ekVML2tPuaibPVuq31CjXK/mKnuQZT3+JdfroCZjOXBmjbkwCBD
 lR7s+uHs+XQgXoOZb9A==
X-Proofpoint-ORIG-GUID: it9zfOZyyVABSwrwBZ6i54vGbHVbms5t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA5MCBTYWx0ZWRfX3KhHiaAlrJCZ
 PfWWjaAKWANSTFJ8RmtBf15TbeCW8eO/kodacRI8iJhAaN7MO2n9k1jBxn2Quvq8HhKdFQYySaC
 ci352D5q6lZtyGqYSC0ee2DDjvMgP98=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080090
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

On Tue, Sep 08, 2026 at 05:57:01PM +0200, Dawid Wróbel via B4 Relay wrote:
> From: Dawid Wróbel <me@dawidwrobel.com>
> 
> The Mi Pad 5 Pro 5G (enuma, 2021) is the modem-equipped variant of the
> Mi Pad 5 Pro. The board is otherwise the elish design, so describe it as
> the common device tree plus its own board ID, panel compatible and WiFi
> board data variant.
> 
> Unlike elish, this model shipped with a single display variant, so there
> is one device tree rather than a per-panel pair.
> 
> The WiFi node in the common device tree gains a label, so this board can
> override its calibration variant.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dawid Wróbel <me@dawidwrobel.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                  |  1 +
>  .../boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi  |  2 +-
>  arch/arm64/boot/dts/qcom/sm8250-xiaomi-enuma.dts   | 27 ++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
