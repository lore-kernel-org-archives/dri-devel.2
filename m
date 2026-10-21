Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E099606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hpOfuolR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DTh65+cb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8F110E2C6;
	Wed, 21 Oct 2026 08:44:29 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A50210E2C6
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:44:18 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L7cdNA502632
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7zeTZgUgaTV5J5UofPRCsdZt2a3+CBBlIX0V3IuvJFI=; b=hpOfuolR0+jKVMpo
 33QmtwARAa+o9NzRh5dyf6IyBefKjPOMZI1lAepMKOlVF9J0ePEmagdaUja7zH2t
 ISBiFiYMRGti7H+dW7oAYM/zYjPE0IKzN/3M5fYAwVhxOnmAcaRNI+luwPePzVHE
 yFYHtBos0Vl5GNjs5z2EslrvwCfVn571NuB78rxe8Fs3CH3iofKDzq72CXBPWoA6
 qAgdVjlPtenDeTuaCRcjbyhYznntgOahi/faGirsK7e4L+yUS6e3jysAFOYhNqBM
 AmrC2VZeims1+NqF2j+yCkz0ZV8rTbioXB9TOFiY92d4Dc/ywx8yTkNP9wz6Y/+O
 VK1pWg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedajk09w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:44:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93edac5877bso15246585a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792572256; x=1793177056;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7zeTZgUgaTV5J5UofPRCsdZt2a3+CBBlIX0V3IuvJFI=;
 b=DTh65+cbX0JiqXBRon8MVg4KqVcvBfL+5qZzxJ9ISb3fkVPW0xzQwm2uDkqoPs7np7
 5Kh5VJVHjl9YuLknekoQWBKIPYaSISIEnYMLjHO2G33HjdHgPBkpn6ytj6rIlyDyqWK9
 fCSJ3q7LXivccSCkz18fEjex8ytComkScR1PZ285wJG8Ewh96muC44ncPEXJAS52Ilkz
 El09Ux5bPOAr9LdVnU0jEXGfu18sgKnq3cbVUL4+Mkxz+0ya5TVAyq26lXVX3/vDQFD2
 sBOBZHZgx39avsLyLDUrV4/1anVRhuVhqh0kv9+ibmtEtqufdGtJ7WhPNtVrnUXQux0V
 DAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792572256; x=1793177056;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7zeTZgUgaTV5J5UofPRCsdZt2a3+CBBlIX0V3IuvJFI=;
 b=CpxWYSpC+TKiEALVs4TRZXyfCe5uyCJ7QgboHsbqnapMbByn7fdvkwwwq89iMTJkI9
 wc0jOSu92ZEsh1KrpqQ3j26WDg6TOuD27EOrw0bgDiT/XEISa9NjQcXXMKdelH5arVQT
 /4s0Qrqf+AH9d4iVE+T3byH4BTHw/1tUkADjvfl2OgrAE5CYfWY99gzGR5IJ0QdLvJtz
 m6J+csCbm90Ie7GL3thGKct0WWFLne80IeALgo8o3Oui83zKi8HGZb2Ic/pQGnCYvox9
 o8FmN8FxhiID9hRyJFZGt0W6U+lTlbNXZu6k9EP9vmB/JBLRvNn/Q+ooYMvfva3XTeX6
 AuTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEU/ZY58R+h9lmyWy+D1WFflJvYwJOzEaY9RC7SGhVsgtQnyq+74S6MkGJVuP3c19fUNuldQ0Wx8A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJPuEYiM/I/rxTVVWcP2bJcWRb9jJRqdf6gI8q1of8kzaIz+0e6
 xIYyn1uBQrPknoYFAKPiZcftZ2MgOWlF+jpCMQ49VHv7EyC2kZUDjfty01UKLsN1KkAtPEHZO6O
 qam8R7G43TzMCtIpXtC4LIvUML1CusIVoa6KtdGbnn/i5RB2yo8qPVCQFDCcqg61AAEOpph4=
X-Gm-Gg: AYBFou2f8OgBppiDbWv48PVxDhcGWa57aFwoMOoz2ARpeQJ2p91JITROCpPPuNnuc1A
 NwNFrk4M8Sz6c6bU2Cts+JWT7Q2iph6NCWiblOK9k/fCu6b3Wm5nrsn9gvqNAHGO3L/Xyc+t1Vz
 QW72mtC6H6FfieMsvcSdOjhCK1XwbA6+iuO25ATyxD0L+4fWZndSRY1dvjzUdb7Z2CcRpwuuGPl
 y1gEsJ1wgDMyAGKTCrR77Tdguxop74u9Eq5/GNLc9LuCdt3VQ915wvANAWDTkkTG7Wv7RWfERuD
 p1vgxTgNmUxpoCq9/EbrLEOR62I5Es3Zlu/8PjWjFeXP2v7brNnQiBSW7vnbSA33MsKtoI0dTo0
 R64vL01U87p8SBZZMI3zm8g==
X-Received: by 2002:a05:620a:800c:b0:93e:5a3f:ac13 with SMTP id
 af79cd13be357-93f57dbbb66mr348786885a.0.1792572256572; 
 Wed, 21 Oct 2026 01:44:16 -0700 (PDT)
X-Received: by 2002:a05:620a:800c:b0:93e:5a3f:ac13 with SMTP id
 af79cd13be357-93f57dbbb66mr348782285a.0.1792572255968; 
 Wed, 21 Oct 2026 01:44:15 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4030dafe2sm602667a12.12.2026.10.21.01.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 01:44:15 -0700 (PDT)
Message-ID: <6659599c-68f3-454c-b461-1947afa29ced@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:44:12 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] drm/msm/a8xx: Switch to generated protect regs
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
 <20261020204728.28844-12-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261020204728.28844-12-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfX/ybJtN5/Dfwy
 yv41jI0QbgH7lW7ScdAleM/LZPnmQcQ0AUxDLaMDK0a2YEch6M71EfskoD2qoYHeQ/2CgaXOw5S
 8J+iMRuZtksZtIh75U37UhJkjkRdZvdt2GZ5JPf5MnfqM8hbX+7QDUYa9ftmZhkk11LYUBMchHm
 QFstp4MTDNL26zyXYOm7/J4rgxLbY4ax03w2emRrrgMPokZNnaULDhq6UHzRcp9+zCN7T88ndu8
 Qn/1PbmY4IV+4E9/IOci5cyptO3eMTlEz9KS+sgbHz/AkKhfTBSRaoTgDKwjO6FfeRikQ1oSvYd
 +KW7p1Zcfto9SklGbmwWYPXvaYk+O7jMmRw4MwjeVKbB3KjrqHACc4AIwFM6KMwuSB8eewkTA5j
 9NbpHFmgO7XB7GHg910Hde8azoDszJB2ZI7ye1DUGCJ9ysrEZe2S3E4PB27cIWkPMo8irRvsFUH
 l7mI+grxN1jXEJImg6w==
X-Proofpoint-GUID: vRzu-zwZ2asRJMyLO-7aX57oQwlB9lb-
X-Proofpoint-ORIG-GUID: vRzu-zwZ2asRJMyLO-7aX57oQwlB9lb-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfXzLzF7kgNfzWG
 bah88zkbQ77X+ttuWrv08DmgG2hxaJDA0aeWG56I1TeYCkSEC1yAiLvWEXqMiUrrEfGRsKGfwUa
 ov9h3LHtwtns/oc2Jj7crCmv0fMHjiQ=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6ad87b61 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Uo0wf__DB8OGiezfqlwA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210034
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
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 10:46 PM, Rob Clark wrote:
> These also fix some perfcntr SEL regs which were mistakenly blocked
> since we previously just copied the protect tables from downstream kgsl
> (and only sometimes remembered to fix these).
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
