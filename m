Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CF0C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C6E10E696;
	Mon,  7 Sep 2026 07:41:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nk9kG9ss";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VbMiSF2N";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AADD710E696
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 07:41:37 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68777vwS3686839
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 07:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n3dyAuDpWbShrONS2lMP2iU1W3wClkzsBqh+y4YLHBU=; b=nk9kG9ssBv3EUXtP
 puStuKyg0AEF8pbuQK79HECIOARhAZGcmqE+mbyvPTboXnCTvEsa7tCrmc503TL1
 gcf6C0G+HgHuohw4GOhXGqmyUuUay3vr4R0B9erSGqGIcCipdOpBd2HGomcj8KAk
 34LfIwXacm1xsIdjArE5+gcDoy6XirkHihE15Y4On9QQwonPBMUZJErrmbjzc4YY
 Qyz/Wedv41XghFBd8MU2d+DSp9oEVTE4zmoOyVh7kNaINpI7tJ/UWBRA0bmOvelK
 JGuNiEqXXhMJ2zRYIjJw/VfvctMGCMl/X3SQg1EFsN31CqpEHEWNVEcCD8LWfmNl
 2bIoVQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gga375vmn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 07:41:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93102454272so45410885a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788766896; x=1789371696;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n3dyAuDpWbShrONS2lMP2iU1W3wClkzsBqh+y4YLHBU=;
 b=VbMiSF2NclJ6r/RCol2CXlwK//yswAZDBAFVhiPqEftqr+CGYq2d16w1p7QJ9me4nH
 og7C6NKA4WIw6C5iP00nSb4Noedr1vMmLaeYAffZaYVcNTrvYrhgKcWuHZPIGty2E4ty
 I/cqIsqvyYX15Q3Ej/8P8unF+MfFra7r6Lfr4Eb1Tk3rruO4P1NAYErvDuMrMBnpbPGD
 wIgFUiSJlqvh49A136fxFRUoUlgPkfBHkUBplgVDQKUB77zmeeytB2h8zzlLbqBq8jke
 U17fK9qVufelw/agZRSA61kufWm4jDN3EhjIoRgJpgsKFKGGEmUCYhL799AXXQMC856r
 s4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788766896; x=1789371696;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n3dyAuDpWbShrONS2lMP2iU1W3wClkzsBqh+y4YLHBU=;
 b=Sj4A21NQTy7Jp1FiVHkcvSSanixs2VZTKpjJS+QL1jOp3VFp/166nVQkmGrKGik5aP
 YG/6mF5NlK/B2LmYTS7RgVNUJckbYhFNslSAF8AqD4youpOnpTToo/dnHfoDC43jzOdr
 cTBgbZW0NvImDa6OJtoGIDQBc6a4WWJHZe23BPL074Cl/tMtRloDKRJKtJArgo73T5+7
 ZwdfzE5bP4LXZKZ3X38vNnFZYYAiFIY88Qz9k0rU4L1N9xOOp0veIrHtEL5rJRO8Ap02
 vHl69K1Z7Pt3CbLJnFtMMroJpnUQqnzsCI3n/4s1XCxVVhn+jTN5xIG0jTakp2IINXXi
 GAWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1CRKB0IzPBuXWNIm+KXPT6izquA86pQbZQTzSFTcxVewMA1icqD4eypX3wjbmWIo67hBSFlun9zo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n244p3veysik6NGVkxR0gR6KCFAp8QIaeeyCd8oWh8fTqdcwgB
 X9hseDkQbJWo24Hc06PaD90Eg7BzLfMJYrjbjrrPM7UXLVT1Aa0JlOqr+U+TPbaBN4hbJTSeXO4
 tea2q/iAIJj+hAAGvt7tSeu/7H3AgC4w9/qr/GLXOlLjnPzjSt3T3aU2CyenWUTBEzvqrorw=
X-Gm-Gg: AYBFou1buPCnC99qq5QikH6FtNBWSGiXG6Xr0COeilG4fSHgDrjVMjYbsWuBPivVSZ1
 +i4pdIiWDpn6/rOd4hmDI9rl+EUyye9p9rF4WGWyYv9U1RzSPm/Kvm2SgOGB2d7D/iLxQ80sCHY
 o1SjUBOC1IwOGmAL+YboTI5ivhO9G0g624tllFAieBOHKV3sJ+H3oQDSa0xhdEV4//4rt9BDiRw
 VNvnJrHUlbXPZLmrbqBDF95Np9OibOVViRqI01CqiU6F3idUU0iV9skemlvCHmgyq55zFJwT6NQ
 FAJDhfA7JaPdr4hntn63wHTUANdzeBHSgVQkZ0y8tKj+e8BDfAsCZeWFYQ6lvNNeUdPxmupW4HQ
 owCWGua7ZN1q48AUsOl2Jew==
X-Received: by 2002:a05:620a:d93:b0:939:7e96:d296 with SMTP id
 af79cd13be357-93980964b18mr1663964085a.1.1788766895742; 
 Mon, 07 Sep 2026 00:41:35 -0700 (PDT)
X-Received: by 2002:a05:620a:d93:b0:939:7e96:d296 with SMTP id
 af79cd13be357-93980964b18mr1663960885a.1.1788766895295; 
 Mon, 07 Sep 2026 00:41:35 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c261f673000sm348405566b.24.2026.09.07.00.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 00:41:34 -0700 (PDT)
Message-ID: <897b62b6-c520-41b7-8599-3ed9ada794fd@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 09:41:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/msm: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20260904120601.18363-1-hemanth.selam@gmail.com>
 <20260904120601.18363-2-hemanth.selam@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260904120601.18363-2-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VWA5ppWs8IjysOFIgbSabfhTOhcYb-Lf
X-Proofpoint-ORIG-GUID: VWA5ppWs8IjysOFIgbSabfhTOhcYb-Lf
X-Authority-Analysis: v=2.4 cv=CbQ4Irrl c=1 sm=1 tr=0 ts=6a9e6ab0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=SkUglc1C9CtHUDT49zcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4MSBTYWx0ZWRfX1VLb2V2V6rem
 MpaXxgKb+8+HPimcy0MCX5N7+aQeFQa5Lgo+QB90qDmSelkLawExcLAHQjiOZj9nLRoKmAbllEk
 QuubnGGTICN47nMlaHQWjz1IPXOHCbc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4MSBTYWx0ZWRfX+DMIT+ISqSCP
 Nan4gqb9P/VO/2F+S/mwAWDsddVpC2cPNsZiE7V5IojC192zm8GqpqdahjgeR+GYT1IUQU3Xq0T
 ctXnkB/uLm8W8Xxzok5tr81WM6B5IafcQ8iVMj+cE2c58jILh61gtc9XLqSD4W664jNdUjH+kHd
 fEGVEGM2ch8cV1o9qMuZ+BAaCoqFmx8MCoX2sjP2NBEuxYohyzSXOMK1EyHvc1pYsQe1sfeOOMQ
 Kaf73dBZUP6IKyj8b4gDNhXe6QAQZde2ONf6bXVtIySk/JyekE1KgjP9RVFqiDyDruaiysuD4e3
 ZakqYK7ZKLdzEuhMAVjpXyBzTZE8hZzE5fXZIIyVIh2wzqQLEeYYcgMFo8Zp2Himss0QH3oozgk
 5QAMTEWzS737ylre4CIEa9ftvERVltF/A/HlSITUHNKTNbktKBzVjjwNTzZLy3We2egAvkaSS07
 6ik65vVxo9IAN8Mv9Gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070081
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

On 9/4/26 2:05 PM, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5

This is a very expensive model for catching typos!

> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
