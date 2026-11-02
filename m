Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B10606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PxZGtLJP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dvN227vr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B44610E620;
	Mon,  2 Nov 2026 11:58:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B77A10ED72
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:57:57 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AMxq1821174
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 11:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XNKwtLEPoAerLUKfTmxvN50PoLCkeJCmqkuTSnSA9VA=; b=PxZGtLJPRS29HD5g
 tHiiDT7NNNUhHpl19C8IpEfL04YWROryX+LiXAbzSklVMNmiKA7WmeBxF0mwaiz3
 yLmeds68Ki/2bl7MXu7CB0ufsF+BCAhHYFXwzGpauL9QpjFhwWwKs3CalDaBPGP9
 HRfVOIEjyIelDGcGkTKHNKa0RQr5PnRjIVFpAsV7VdmMJcihhlC9gL/xLNm7Ax/D
 pynLKrb0zNUyGET23tDaXogLz99WpdjJVOpuMEHy738NO4BUmsEbeUaoGkqReCKh
 ToCWHO9Dmrk2q5/2TFNh2p0e8EZ7SVmjyomWstG2PZ5LeZ+6dN6U/esbHycSVA7V
 AefRAA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4hh9b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:57:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1f1f2ecfso49144585a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 03:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793620676; x=1794225476;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XNKwtLEPoAerLUKfTmxvN50PoLCkeJCmqkuTSnSA9VA=;
 b=dvN227vrXbu6jVxtJJb7FEUX/O+jQ8+9XuLCj+K/LstJmP2tvERdwSPWus9e5874PB
 JgzLK0APMwh0HkVKxtzLUqJG0Gkr5psSm/eq8VorLPnB/j+/91DkArnzD6NZ/Cd+aFmc
 zuCC0FoHt+vtwxvKQtSRABt0M2xZA7T6M8q67uD8rjC/qiiL2y8vp1ln97iX2GZQ6/fE
 GYRrcnWJUucEqQxn7no9d3VWMi5zDt1i81wcCryUNdISivYDKSHhlJK3Rqa2OQG9Zzzc
 j6oB9gx/vrinibuY6YXkz3x8yg4V7hQVj3XDglcgilhLhkQ85orPNhDPrctgt1HwPWTx
 h1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620676; x=1794225476;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XNKwtLEPoAerLUKfTmxvN50PoLCkeJCmqkuTSnSA9VA=;
 b=p5OgfzeoGqCt36bxtTt31pk13P3SBPdQkKmbaup/CQ3eOW7TEWBYts0LbkDdJuTyT+
 Oqe7tmtYF2mWI0Gn4AssT89k2fcXaINT3jcVXlvY0g5EDNfrtZj41F1lDx7EYjj0/kts
 LByCU1zo+GUScYPCiy9pNmSRsQS3YlqpGxkqUVUaJRxVONdaAjKquSJIwCVfAXMkTCA/
 ukUeTTGI1wImv0mPAEJ/ouxNWojI6PnaBtOEhFMVUuNz3Qby7wvg7XM9ltLHo3ESLtgf
 GPlzl4059xvI/ecIzvpnyjuoanFRMfxYV5aIX2zydtxDcbl2cSfK76TRe5WhAwuDx+B4
 ESVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7xqScsJ2BHwT9raYLybDU2kylUKhc5zMG/Dap7HkGzVjKke+5iVA6hSa43GTKqhbUK60NbDlhkv4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLl00InYL2/oaOIEqmsFLwE7MHGBmWGvTs/KWK1Da/jRJ99IpbO
 AXH0OZ8gI3dspJyK9QNCk8mq/fifUlTHS5PLc8MDD3r33qaFyRmpsjS/IwzQgOe7azfubGfnWza
 PKGMd843GWsKlGulnr1fhwA8iG6JgNYKrcZqwaqcWiiJz5vZ8If7vDPQJmWNkesuItTIu4Qs=
X-Gm-Gg: AYBFou0xHjJ3Vvs46DwJFJ8DNF2qw1Wx3zM2jTJ7U1ttvjg9Car/PJUtGmiEd17zZEf
 tCQh/43p/B7k4MlEt8lzQQIlZZtGCcGgRUjSH99e4gTy+wPbHN3KVbEDKYcgbCS/iH13EVbRKo2
 enVBOdRAIu6j8hKDag8VoNWQvIsgMJo4E2ikszqehf0ORe+cTM592c8IElX/px3Yi4+tDDqRiye
 zJ6yex//13L26HxBbTt81E0hQyNuw48SaIVgOG1s3hQvBnVN6i7yKqSvzSRjnDPeX5iRVm3rDLH
 /Sk8Tp2F2P14TZJTfymIYzyJzzxX3XkIr3ibX2Is0LXFT9SGoNnszqdCwRrTjRhlfbQGJ0k3fPZ
 50+iqb23VoRM9gYm5LxSuLdsFaTKw3qYkw4ZORbieGEpAPncld6MmuSHhoK045HpZy4hJsJM=
X-Received: by 2002:a05:620a:124c:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-94421734130mr1761509985a.3.1793620676061; 
 Mon, 02 Nov 2026 03:57:56 -0800 (PST)
X-Received: by 2002:a05:620a:124c:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-94421734130mr1761506985a.3.1793620675652; 
 Mon, 02 Nov 2026 03:57:55 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabc18e78sm387008666b.9.2026.11.02.03.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 03:57:54 -0800 (PST)
Message-ID: <2392949c-85f4-4cf7-aece-df3b9dc86cb4@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 12:57:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] arm64: dts: qcom: sm6350-lena: rename
 touch-en-regulator
To: erebion <erebion@erebion.eu>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-2-cdc3be96d257@erebion.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102-pdx213-upstream-3-v3-2-cdc3be96d257@erebion.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QWQuqqoWUmoXJ553C5X-qZkrmliyY-3b
X-Proofpoint-GUID: QWQuqqoWUmoXJ553C5X-qZkrmliyY-3b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NyBTYWx0ZWRfX8CU660AjsI4F
 Bhugat06eetEjRUvHqBYDpTSt6lDU8iRdPW+akfV9NceLqPvxJW/0wId+6ziounqmrHRq21nypE
 OijKYRVNuwjnb+4IgRmQPKKhocHWyGg=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae87ac5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6H0WHjuAAAAA:8 a=JgZe5hknAAAA:8 a=EUspDBNiAAAA:8 a=RC7kgf61jvLRIQ5xqpwA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Soq9LBFxuPC4vsCAQt-j:22
 a=ODtDA1adfiiB3BH7YLNA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NyBTYWx0ZWRfX47eOxuXH3MVM
 1FmK6hFe6+jdYxcLpRZqrWHw6//QbWaD8+E5ys+E2lpj8r2NLj08F/kaVF5/WmXBoakS5JWJc0g
 SF6ysVjavW+/LuRa5UBxHivA0TmIAu5LuPjGnvtBLBc3l9KQQWFUFWjNwbsqMJGGFk582UmmvqJ
 VpEMXNaXVWIv2QZMILDDvwp1BezFWJQ+LDcyXu0Bm9AA/whgW/wjC9OxLj5LwTFRKY5xyDIeuxC
 gCY26RXgyT3toi4WYooeRcM7/3Catq6QhFnqVAbViHbkTR51LDYTKQXBWB3K+zvEKR1osLLV8UJ
 cd4jgAZuenj5GHT6X/M2Qpanz9qsoUmSlkbrCYjlZfniFBl55btiPYzKUsrerUZ4VIjU0X7rMVp
 6dp62aIxEG/O//GH3oVe8WnWIVql8PDTKTefG+loQVtU+NDvO92jdJaqeBdWjANdlAqflKkFfNR
 YUMDnRNo0I4OwjTiUNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020047
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 12:32 AM, erebion wrote:
> rename touch-en-regulator -> regulator-touch-en, to
> keep any future fixed-regulator sorted together
> 
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: erebion <erebion@erebion.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
