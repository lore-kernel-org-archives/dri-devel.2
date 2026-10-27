Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC6606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k1/6mUXN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QssmhxTV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5707F10E179;
	Tue, 27 Oct 2026 10:57:31 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E206A10E179
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 10:57:19 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAe9f13026372
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 10:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6Xs7gTw0KvqYciU+Kau1HiI8
 SAmkgSoonHql5kcru7s=; b=k1/6mUXNIgFhNYWqNZoqANg+0ig/u1xWRNSyuVej
 XRQar8CaJAP3chXDH4ger/M175PrTQbAFr256q7GkNvpfPKxJChrwSkwzp5LbOre
 dM2gZZaL7Fcoyfz5snUxxFYGRAIFH3R42Chio1Zan72Agh+9L7yIyaJhEc2GNHHT
 fSVY1fArNbdhpdI1VeKWrCNmRICZzqSaohodEZOFwAlV/e/W7oOZ0L9buVdCZYOm
 97EdESnmayAtt8801jagnQ7drcjxqyEZNKTwPVHBlxuJvY8uxSQ4QaxnzooghZ4N
 dJGDoi9NTZ6jCYMNBlg6DCQFiz8JqNYYsznBsWNI+cPH+Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjh91a3k9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 10:57:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-86f102230eeso430034b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 03:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793098634; x=1793703434;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Xs7gTw0KvqYciU+Kau1HiI8SAmkgSoonHql5kcru7s=;
 b=QssmhxTVfxdRCYSirDH7g/IIrVjdfeGwvFvNHN+sz6/J42Ws+vdKkli2z96LLJ10bA
 PnjK4+qbB6aID6884JCgXLNxjG7PZUbSWjER02s1WOnuWdwQopXhtQ+oo4fILbPuvSr5
 pYJPl28HUfOTHh4U72ekqefzcwRIoLPoDBMIhxKs7mu7TD9937VD2ZZFkqF+Fr/UTjQd
 WOiCfBhaCU0znLO0vGS9TBRIrk+kTnXKb631x5Ecb/KrEjZW06gi2P+pS8DChuplV7xY
 50+QVpKMV/0wT2c0MOPSkUz/3vYOK4T9QtyZw/XpJ7JE94x3UfdXJC3ZbrV5AqeKrbeU
 4WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793098634; x=1793703434;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Xs7gTw0KvqYciU+Kau1HiI8SAmkgSoonHql5kcru7s=;
 b=AtXQgPB92VMy5aqMH1htdaXjgqDRkzGAY2r9c0OlmrbHDvU9uHjfG4EttqOiHCS27m
 OBdukK/g9OKYLMr3doRrLTvGqr7xfQQeIhAHKENZIhuKyVUzBPsHAydZEqw0d7GuHqSr
 fpRSHwH0+NoTYz0DViYt8GMw91znJ5KXHbjYLm2caUjBmUTQRnm2eI+Y8amZrH4oCCuW
 77epjShfJgDEtdTARwkiseuXna+zCGVbX5eL995Cz0tWa4yHCiel0bxL1X/1xkLkQnkq
 xPOJ8ZLiSXYGREwpnlZ3VunaLmkyQVRjrrIgUaS0YcjkmE1XOFd4fleWJ2Izx5A//VuN
 MFkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxttnQKro4z4c8tLrXqM+Ca7+rLWqYCi76T/gx9uQYG3FLy4/JmZUewNPubeiV+oYQcH4JxtIbyR7c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYICmjY6Z/79iGgIgSfypTEfznqJN7/2LUS7yRb6+SA4OJJuXPDO
 lOdFd/SaY4cCjAc3XO/39N84vEurq7RLTG5YJsOdMfqIIUe01gpJ7EPAtRuGR8m4EgW+mnE0oHK
 9I31zVW6f85XWn/Dh27wwiItdjFcRuKAboVOb/dyEWpA/9AJ49x+d8nKC8MEMy/OC6Q6opPI=
X-Gm-Gg: AYBFou32COpZ1QvRwQquoVoo4KFyyKyB+GhhFYDYvZKUNgIH5NdEv3+dGEezkETREjv
 iLMycQAcbMcvuwjJFyOxnFU0jPYmtBOzM5qkH6K59068/xxlHxeizbBLvGPLMQ/O3XDVqfQC/UN
 hUfo0r2htWopcNyLl9FpHQWCatQJorvUnwgUDOaQzJMfhlh6d+0tg2Gz2JfaCQTXjPehZIV9I+p
 eJeubvtOKuYvn6bmo8OeqJ+B68zTSFjh6HSyQzvM/1OpC+9qyQ8AgsIX++EJyLJvd79xqjn9qvA
 JZW/AkuIJPs9bDNIfOghdeZp7zO+3CNAnWqfpLK4F0cPDiYJgopdHBoUhT/QbT/bNuAN0xhAYFF
 L0NLd8d6fspvdgF9IOI9IXL9bFQIVua2bSo/MVtANrvzB3d77SmcoZGIVu4BqUtRJNQGvU5aCEE
 MftD2aGrGip8PIgfyMnvZPQkXXYP/cYbbnFqFBtcKqa9R86CK9zPeM
X-Received: by 2002:a05:6a00:348d:b0:8a5:866d:d5b with SMTP id
 d2e1a72fcca58-8a5866d0dcamr9445079b3a.1.1793098633651; 
 Tue, 27 Oct 2026 03:57:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:348d:b0:8a5:866d:d5b with SMTP id
 d2e1a72fcca58-8a5866d0dcamr9445059b3a.1.1793098633216; 
 Tue, 27 Oct 2026 03:57:13 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a36bf0f4dcsm2190344b3a.44.2026.10.27.03.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 03:57:12 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:27:05 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Arpit Saini <arpit.saini@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com
Subject: Re: [PATCH] dt-bindings: display: panel: ilitek,ili7807s: Allow
 backlight property
Message-ID: <auCDgewe04WKbamD@hu-vishsain-blr.qualcomm.com>
References: <20261025-dlc_backlight-v1-1-1d1c49c3e101@oss.qualcomm.com>
 <20261027-fantastic-benevolent-boobook-272a9a@quoll>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fantastic-benevolent-boobook-272a9a@quoll>
X-Proofpoint-ORIG-GUID: fFrf2BRI_RIwD3R_4AVkZv1PTS0bgyV2
X-Proofpoint-GUID: fFrf2BRI_RIwD3R_4AVkZv1PTS0bgyV2
X-Authority-Analysis: v=2.4 cv=TuxzFzXh c=1 sm=1 tr=0 ts=6ae0838f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=a2tH-4IN5IZEDPfwvVoA:9 a=CjuIK1q_8ugA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0MyBTYWx0ZWRfX1Lehj4TBNYAo
 1t7rgT1cBuB5cUnXY604y7uf29YXU0IfW+D4sKhb7pRRz0WJtzaQ1uEvvuzwIm4+u+Yfvb1volG
 k+6JjYgUEIpMYVJtmJ/NcgL4f84MydlmWki6m4n95Qaq5blAWSQfpbSnPUkAzGvbJ1qaDQPFkJg
 nKJ3o4wSMpzji4YU8DF5cYm1ALYDkfMDZSO9gahNmJgJYmUoqGsRzgqbdy6dqtO200SwFJUid3p
 HP8O6yFX+ub3ZIGO1XG5HwJLwse/gLICtCVPvse9Pue2X4qDNIZ42LDyBabgRIcXQO7EhYE5wvP
 h7D1gHRYgAUoZEl6JGarGmnFqWr93bKNf67keE/ASbs0abu/pJ44Pej/xlCLjsc7t1A/kdw3dgW
 Ff3s5/PcfTjjRWderzbG4ASH5ZqRCj1XS+OeKte8dXGNNsn20C+sGvHKTkUGnUAg4lzJJEwUOHO
 spk0Y3SXB5UHi/4cGPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0MyBTYWx0ZWRfX6ruGroDpPHlt
 iyGnzToXYFjHeemBN5DFHfayzXJupZe9hlU01iRbaoNE9mdMj3AQsjPZP5919bToQ/7+FD6zvUe
 Ff3uXNK1Exkfd0ni7/qd2Ksc2n5ymok=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270043
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 09:12:27AM +0100, Krzysztof Kozlowski wrote:
> On Sun, Oct 25, 2026 at 12:18:17PM +0530, Vishnu Saini wrote:
> > The DLC0697 panel is lit by a separate backlight device, which is
> > referenced from the panel node through the common 'backlight'
> > property.
> > 
> > Declare 'backlight: true' so the property is explicitly allowed by the
> > schema.
> 
> Why do you need to explicitly allow it? Since when?
> 
> I see no benefit of this patch and commit msg does not explain me what
> that benefit would be.
It is required for below DLC panel, when enabling backlight using gpio-backlight driver,
Apologies, missed to add this in dependency there.
https://lore.kernel.org/all/20261021-shikra_display_overlays-v1-2-adaea735999f@oss.qualcomm.com/
> Best regards,
> Krzysztof
> 
