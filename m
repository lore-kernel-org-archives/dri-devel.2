Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C641606D80E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FiogIaaP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L2X2UFI2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C34A810F518;
	Tue,  3 Nov 2026 11:40:50 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6519E10E80E
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:40:39 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AAFa73161758
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 11:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D/FO6YpKaEZyuI+tOQ5hSqOHGNnCb5sKIIH3PegRd3c=; b=FiogIaaPYpXXIDum
 pitbsoBx7M1oAzx4YFWUUWzflsdBDarJmI/IoIR6QOi6bVlLDcctGiIVzccDincc
 O33Dw91buL66saAR6Tnxa6xwSxSUDCNxB0KxREl/Wzweny65VyY3gcFkKQppjvIl
 thoQuscmRvHsYGl9//oS+drgX0uJeDF/R9cS5Sjt/XT4B6BneYEx3W6s1sZpXQ0I
 DPcmODvUnQPX+DnGf79YkA4spKXkYDvFqlqMwQduXanP7zwz0JNC/g2TGMqUfGHP
 sjpMPMihRr3KCNv6jeomr/NlYIfgsuAbtt2Dk2p0rrIvYk6WKUE1pvgRIpPabsBc
 VdfTOA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m9a1kk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 11:40:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5476f5bd009so4717151cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 03:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793706038; x=1794310838;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D/FO6YpKaEZyuI+tOQ5hSqOHGNnCb5sKIIH3PegRd3c=;
 b=L2X2UFI2qCmGJ27HZ+nDfet9yCC+a8BLrbZXqb1Vi793kECu1di4a+tXjEcdY4edNk
 j4ud9lr2l7fWCwBBEspRP383u1U1Eqf+wx3EHTLLyv5jZu3VCbgc3hOJ3c88D4p1zpRr
 Eq12kAjw8pkuf7DT4n/1y+XfqbGG0AF262XMxReNv76S+C89AtnGrnkqiqEuayYjAAee
 OdAy7PrVKFw7qFdBKFl4NmdrDiWusqAATpVmHWZaNST/ktgs7eIF/bIe0++4PhFdP4oY
 akb2ZyUiVqPfSlaFalQH0g4matpJlT2zGYz1FI1YqevrP/WYHO+o3sCbf88w9ZRjS2fw
 QdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706038; x=1794310838;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D/FO6YpKaEZyuI+tOQ5hSqOHGNnCb5sKIIH3PegRd3c=;
 b=gzMFEipNDd8clg1loFPyRdyMqKxqzH5+qOUQVMfzM+8YUZrvA4RshQ6JV5Sz5Al+0V
 yrwUAxDvjh8ywbuPBGAWBbInJqOa3A698+2u5jyXAamuh+z9FKp7t+/KADWZWVvH+qE5
 D+PyZGyFEpCASZQxClHTl7Y+Jch+XjHC1Xdf0DL2PZ5yWOryyzKaGYQ++KUjoJB2Ofy9
 sZm9vl5lY62xPf6V5/3p2XaC+ywmG2ecVtXeXUjmT0Wiqegcu6UDyvvjCvGH1dBAHG7O
 agcNqDr3XUQqgE/5MMfg0KzRdnaDObN2YK8Mb3EfT590eL7OLcCfvvy2+Vn/wLxS6kB4
 FsTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwApBh8NSR9aK39Z8xQdFcQhTJ07ZFi0kLJNKq4+4wGrogB5lRYVk/W682yV64YGcPocq9ZPjPmTHo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Dj96wiWbdUqdnM+5t3dNLnOykMVl96VZp++4/in/eKUZR4ST+
 0ydVj0XktADgRWsY4T697millCT38qNGPQiuYEPhlHMvIGLOEy05jW8zXRsIOXrKyloEs4OY8Qx
 pbVdwgoAHWlXSIE10zF9ha2TxvBprw76MtVmwaYE+olbCaQ7R7ZDD+xRHM80rfTeZmVmP+CE=
X-Gm-Gg: AYBFou2ixHcIpBZwb0MinIbORjVhQG0IPzMVhHQm1Jh14PhawKmnmNhyBsMpSTsVqTJ
 eNtMq0guIu5grR9qUW6vl4A6xx59tSxNEzRX8QNFJ6qP1rnAq9gn+g7j9k0c3Dw+znRsUiPFO/L
 ZURglrVva0wbEugSA3J8ArlprkvBgeg+Vp1bT4iAu950oHISpuEU1w1Qq23RuZI6g2e/ELPpRf3
 ft/UXqH+ABAYsO1F1D9qsfXkWOXJuvdQPPeM6GGR5VLmb7S6ucP+Jxc7//vlsomekWw7ezSjR7Z
 q/RUvzyShb9JPelNeqaHIVDYlt1YeVSgCsGfsnkhPEcV3Wgk8JxEUXRbVOLgYrChVckvhqEuyw9
 Z7NCjrjJgYY2bNN+sr76HIoPbPsc3r/QF4ENMXd49TeZh7s/zcxKc7GX7KmiIPtzk2awqqQ==
X-Received: by 2002:a05:622a:8447:20b0:543:18d7:1823 with SMTP id
 d75a77b69052e-54318d75457mr190129821cf.4.1793706037756; 
 Tue, 03 Nov 2026 03:40:37 -0800 (PST)
X-Received: by 2002:a05:622a:8447:20b0:543:18d7:1823 with SMTP id
 d75a77b69052e-54318d75457mr190129551cf.4.1793706037206; 
 Tue, 03 Nov 2026 03:40:37 -0800 (PST)
Received: from [192.168.226.81] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cebf2ef54sm75777466b.47.2026.11.03.03.40.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:40:36 -0800 (PST)
Message-ID: <e8075b30-3407-480e-9c83-320b15001f2d@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 12:40:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/msm/gem: Decrement loop idx if handle lookup
 fails
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261102172001.508440-1-robin.clark@oss.qualcomm.com>
 <20261102172001.508440-4-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102172001.508440-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gl7pLQFUconz8xmCZ3SPfKchZtSv56PE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfX0AMN/1XloM/C
 isSvIK8ioi7M+M6AWVOuNC4nMKV+PDfq19GMWC7aO84GhGS1EoxMl9W1tg9zt9ptEp/tyyLWBVS
 m38T48NXLO86naxIB4Bm5Igzex310Jw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfX6W/PuVjYtXWe
 RP7kiKwK8dBKKvAxhs1V1tebaRkO82lDY+auduqLERuJj9qXX0k4Z4acQtFBOUSMPEP4lvPufNS
 Fuww2moqo7PmeqTUzpS1SJpZxCOV4fjLFoQ7ZyZUaNv0Tl9xi0czqj9gIaiU3TOdYi6WhbEOQPM
 WzSuXxKsrW6EhDQiO06S9fSodaFbSuKmOvRcDvhNkdzO3OIwEJ4RjfZAnUpMjDjskX79EaRtqFG
 lJJgWmbe9RxMRjnLYTMm7woHiTCjEmjW5AjJya4WUnRIeNFlyeA8VYwiVdEbnX8/L/ltfCPTM+c
 VOL+XuQX+f2hz2xKRNV0k0GvuLzfQrDnYZM4LpQAbGTTRWIivYcjPmJ0RR1ooNJ0V60jShiRIhl
 ouwuryQ7UWfhJ5CGBkn6V1sMO2wBdO6Cu7IpaNmBhVPooJCizvK5u4g8Dmjzd5TIBHy5nyWMHtO
 Hdc7O+3M2+ZjPo22WOg==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6ae9c836 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=9tEP0OE30YQ_IqY-BwIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: gl7pLQFUconz8xmCZ3SPfKchZtSv56PE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030046
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 6:19 PM, Rob Clark wrote:
> In the out_unlock unlock loop, we should skip the op which still has the
> gem handle instead of gem obj ptr.
> 
> Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
