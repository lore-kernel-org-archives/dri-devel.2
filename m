Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F560A2615
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ScWgBRoi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HlWm0x3n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEFBF1127D0;
	Fri, 30 Oct 2026 12:50:28 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A1710E1E8
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 12:50:17 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBFuXP4116358
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 12:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +36S2XfMH3Fmmp6nC8LledtkU6qCJGGKMmxe5Dy6N18=; b=ScWgBRoisjo6bcu7
 P5SRMb1wyAhYpNggksh+eq+iYxsVYjGMrxjc3KYI8rijyR7secQ3ot2dfUlEYSql
 KttF74uobKkwHgM4p+tfKTwDGuCDB6zCNz2mvALPEs3FD2PsooWXRw4Qk7TyqkS5
 P1cykXo7eDnV/etd686Y2aUv2/G4rFxhsx4kgzB5ofN5UF2SAtJYbg6jSFMrcUCQ
 o0UPXiCg6mZlFFEgGhVDKcYaxIGDKSAGJpO1kAsFEKgiSO2LP6oVruFdok3N5+oC
 LuCL8ekSVMdsoAGF3smEpInCy8xopFJVp+CDUP8M7HXMSupbTvuAYRtpZq3r/Bsk
 ldT4Pg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rk5q7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 12:50:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cac495d99so3476985a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793364616; x=1793969416;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+36S2XfMH3Fmmp6nC8LledtkU6qCJGGKMmxe5Dy6N18=;
 b=HlWm0x3nEQM2OfD7by1xDryounyzu41b0s2qdUDdV+t6PNje8YLoJkBmCrG8SnSvri
 f8Ge2ArJ3+kW8xhCDdyQOinsW7g59axA7Yo13cXmabQDVTdZKx1+zyCY/eG5G22Kgdv0
 M1O64vHbAwzag06O9H0lmjaBztrGQriyi5jXNeW8PUhoinKNXehbtF9yBREpqcaDjRbV
 HJzL1WY+t1/34pFm22hC/z3XVu0akdWqphP63Iw3An5OciXdTlC8hGYRoptf3O8MiS1t
 oPWGwCzSjga4KhBbEDHc34QA2Io1E/q219mbWNfYQqBa6vK2ilu3Cb9PP/jaipm9tne9
 Mgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793364616; x=1793969416;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+36S2XfMH3Fmmp6nC8LledtkU6qCJGGKMmxe5Dy6N18=;
 b=d2OaKD9Tl+KSHC2mXkoeFAfUXK/UJbJtzNZFvjdboLvzxO3UD5FvaeKD47ekp2cfJH
 wQB4ye9SsMzBM04YmuP+9HYaE/HsDIaTe/zeIk7JKG1HqhLRb/UszrHBfnTVr2oiF/VP
 dUuCzPTfI1ippO862QBzv26aAiT8K0ipNlCr3LEUgfWIam+BujCPIt5QZp3lrbPmSQAk
 YuJ5/+YWIpQ+4O3tWePuI3EgbaL4oi96wYVseNzDiPJC90qix4NLHYphkfZ7+6kbOwP4
 nWd3ns1nhnXUMs70GPCdyA9OpJP0o5zWeL2rTp+hFMx1p4GdaQpjXJEPmxXzCrYhBZHn
 Nz3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8VmhwZEx4+0dmGfGQ6xX+bkA3WbMvvKGuN7lLTStNGJJMwMOCg6N6QKJpBLWTcE4rauEjRQx2skI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJmcrmds11UjJTq9IUNGNJ7gp+OnICOV0tPTxxnagPqMKS8Nd6c
 fF6ieY7bzC1jbvU/2oVDxt6HK1BbGJtNNlqVV5Xws0TcFdAN2fqk36Wlyupj10AtBtug6KGMRYB
 qnXN0IB/4GzAuffX4prhy3Tgo4vD9beFvO6bPYTvcUuMP9Egkj95JRjvk4dVFJuvnNQbmD+w=
X-Gm-Gg: AYBFou3o1DsTeFIvhvDqdjRHaT7BmWb80dhELHwvBvmdIsyRh1I5UCc300OcpivznzT
 gLNyU0tiJA7+XA1ZC5sVxJhAuFrxTqsEhBr8lWFN5zn5bh5J56pNziDpJrfPX5NnV6UpONaB4wE
 vkX+WojQG9Dv11cPwOp3LY1UBcpe33gA0JmdYk8PBd/PibuZF2qv1Al8+4oQ+1WuSb0qgO1n5p8
 rNUTuSS76v7F0nfzvdHoEJybPqxQwzrmUm1ZVCnmbsxyKbWviV+eDC5cw3NNZPHX+WzOuOvix1V
 iMRAp64oYV/tBURFkectJkDIy+O9wTjj5NeASCDaQFEHXmwQekyzBRmSITkdiea23gUHlI/D51K
 czl/nliQAU/T9KkRXSS/+HEpJdptP5LT1/5aXOTW1+I14XfItXOcAOPeVxPTQD9k+JJ2Kp2k=
X-Received: by 2002:a05:620a:a8d5:20b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-944214c4e2dmr364699285a.1.1793364615960; 
 Fri, 30 Oct 2026 05:50:15 -0700 (PDT)
X-Received: by 2002:a05:620a:a8d5:20b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-944214c4e2dmr364694985a.1.1793364615590; 
 Fri, 30 Oct 2026 05:50:15 -0700 (PDT)
Received: from [10.169.205.110] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe8f9bbsm62954366b.67.2026.10.30.05.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 05:50:14 -0700 (PDT)
Message-ID: <415ffc75-d1ed-4540-9a55-dde0f6bd24cd@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 13:50:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm: Fix GMEM_BASE on a8xx
To: Connor Abbott <cwabbott0@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20261029-drm-msm-gmem-base-fix-v2-1-26b338471b46@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029-drm-msm-gmem-base-fix-v2-1-26b338471b46@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ryo9IhMotil2-SXsqcMLprg6TONqb8vh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MSBTYWx0ZWRfX/wOMlb9VB02u
 lhJdMWTAkiWLawnDPMa0whkng3fGclwoJJuyGKgz0FHvtJQ6JkNtk/iU43KAWwVRUF+H27/tElG
 dSCp8jLmmZr+lbSOXumDugHdsz7EuJY=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae49289 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=XAuXcVFvbmlwbjzS6hgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MSBTYWx0ZWRfXyupz3vxsfaAx
 yVzmeDp8ycs0NwrXEDDermT8udxWxsZyLrkiHurfpRo1S761BMtYGz9VSEgO8uOzQEV0X1wLWJ9
 eUXsWgIPdylKSaCbmQ0SKoyfS4FRnq1lG3ksshKZ5QEtHOVeBhX+SnL3+Ysz9aDvaEDOPRW+yID
 H9wlnPW7GMu3SsNsIK+cvvCYYzq0kTOqrcV4N6NgmAy5lpUD63navcEuFjpYthqaeZoqrnKIv4J
 dwRuCbRTZNYMuhiM5jkIPpx/nL3OhhIfGkEjjHFrdIzXzotbMc0m1L/wy9qkNDc2Ww8V30oH3gF
 MaUCmTteoLZq6WR1YYWxFQkI9a23i/EFB9SYV8+ZB4+qjEMAbw8LBySHS+HgUyKah6rIitrrDcv
 kDYsSX+R4IJFcSDyS6b211jAw52GwjKqmxt9GDkosDF8eHLsbfhHhILsQf3Pr+RhKImTeyT7CmR
 hGN6/1faMFlyYN9xQVA==
X-Proofpoint-GUID: Ryo9IhMotil2-SXsqcMLprg6TONqb8vh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300051
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

On 10/30/26 12:02 AM, Connor Abbott wrote:
> This was missed during initial bringup because GMEM_BASE is not used
> anymore for textures on a8xx. However other things such as mesh shading
> still use the GMEM aperture. Fix it to match the value programmed into
> the registers.
> 
> Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
> Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
