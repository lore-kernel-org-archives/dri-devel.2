Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B35606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nYAGL/yJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IuwpxV59
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E12A10E275;
	Fri, 30 Oct 2026 16:37:25 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A650F10E275
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 16:37:13 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERJ2C4103327
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 16:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CjbJSOWFP4xYzP7X1bUN4tGaG64TBbEqFOZGqIKWWHs=; b=nYAGL/yJntypMrfh
 f5q04ZCHq8xC4PQJ5c4omUG3V0lfmXzMwQ4NPAXypGk27zULzQnz9pysSzJ+1h/5
 xrUIxUhrLjy2wyMM34RhybRi1FHmjZOxQN8xKtgl3luCRBkzgBGqg63Jsvf6iG+n
 Tsh5dmutYXpnYQ5QLCg/dTnTFFYz5yL0ZdkDLNWP2FWiOWfWxJJikUOQyKH7AjAz
 9NyVdSaT2fbPqiZUmdvf/GCX+RryMzFbguv20BOtHRVCJTd2seJnu1imSD/Ouk+g
 1hWxjy63mHwhBTTA3zEFXjWarSSYuocJM+PClpM5+B6Rk4QfXMfoBNgksIwy8F5F
 dlMdTQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm1gh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 16:37:12 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7cc1bb97ff8so198372137.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793378232; x=1793983032;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CjbJSOWFP4xYzP7X1bUN4tGaG64TBbEqFOZGqIKWWHs=;
 b=IuwpxV591nDQrDY6+ldAzCnXW6xw3SBogc7LNyib57fCVQs9IvZgpKcS3QHV9GLlqs
 Z1zHyoMDK7KWguxdeyQdyG2NKeOxmCiwW/74IloepZxiZUrEcTpPvHYLK0a1WNS0pkNc
 XNJrpeloXKIR9YOBHYNtMzqVsWhjSuOZpxEeL5nkbAxz0n6wcB2LygV7svyqFjGPbdIe
 YDCnVHk3xhcNt2pZL04Xa/5FJgvxhAr7Km0YV1fErr784aq1vuN73hHVfIjMAB3TpSUW
 ZU6a9BD3AQgxEdweRqXQVJmXLMIkohYMDW6kmWb+AVLzuBRALnNxy9ci2apNYS19YwUG
 CAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793378232; x=1793983032;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CjbJSOWFP4xYzP7X1bUN4tGaG64TBbEqFOZGqIKWWHs=;
 b=YPYX35uEQXaIbwil72X2r1nwXH1TUxFHilZJ40u4HL3vAoAZ0xk/Njg8+zF3GnoaA6
 NKs4wb6ruUtYTRwPQTCULnt202VLyXuY3Kh8rfaIIB9c5ZfAw/zS/YnKlxRFzelap14I
 LFvZL36jAR1iwzHc0MwGHnHQhlkqChJgEPOjeyobP2+NriOoiqVEEI3yDdHFnkTPFASS
 pHAiPmp4ppeXBfVqD5TkiKJdgFf3MQESK0Cgq4xJsRxEDA8YvR2qEBaug4GyqkzS01zu
 xOxbmqz0l7yBP3RSTZT8S+++RN9fDZCo/HTsXTqZyRc+8DChx/xJ/nDRSwqQ+8pTwJs3
 QeTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBws7FJNtesSooQrSBBshJYgduHeRixkbKEs3HOCv3s4DypxpHLjsR0LbKxVfnDjiCiaFhNMRKtSuIw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJy6g0gmtxyTxl8DqmlVoGu8opkQUVKQ7pwofb3IzOM/nRtMUuD
 YebC16wMPP1e++4RsIRc2R0poevQ1NiipdO2XFO9zhAxIv5B+wSdBDTXoPNEWfmj9eD0WCjqKZ2
 ga2sKj+gnoal2/Q7ReNrLSKWAM3tk1ZVDCc6wXv43T1vaE0OY6/f37orHsLiMMtMdlAG3bIo=
X-Gm-Gg: AYBFou1yU0uKfRhMUO6wXhazWzw8a3bCIWO4UFfQnuy+buWxCG498OZWu4f8EqEV+cV
 wlkxl9NJZKOEl3MbnC3pf1b8/sGJ3ZhiU2wkP5LIlq73eBWLBU2dJgZvKisirAcWXJ/stqYSYsu
 8kh4pKuEwnqZBeQtGyO3LxB0HgD8/Cw4r7mAufzZuf2iNG9ivxHLPqhT+ISeqkAOqhNoLTyDAx+
 mbZa1xVttOgaH6NO8OJYeY7OQhjEQ5LiOunVpjbtLQ8cI1giiKCjIXeUsaraPdTUyJo9zy1UqBc
 7gfql7PYz3SyxwuZkJdlNbrqXl7FrxUXBj9Uhr8Zl/5nf3+2TThFD0IP7EYKk4EgegK+Wyq0NY+
 aVulWPkAaFGzn33bWpx2R6mUi42Rul3n+Zsv92gzRFKqenT/VWIDgV4FLvjkT4vR/V/6AsQJ/rj
 5naDlWPMB6F+hEoe3rhAesBHg=
X-Received: by 2002:a05:6102:50a5:b0:7cc:25bc:3b20 with SMTP id
 ada2fe7eead31-7d072bb35d2mr1346723137.7.1793378231609; 
 Fri, 30 Oct 2026 09:37:11 -0700 (PDT)
X-Received: by 2002:a05:6102:50a5:b0:7cc:25bc:3b20 with SMTP id
 ada2fe7eead31-7d072bb35d2mr1346703137.7.1793378231149; 
 Fri, 30 Oct 2026 09:37:11 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-992ee4e7453sm3074546241.11.2026.10.30.09.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 09:37:10 -0700 (PDT)
Message-ID: <722539b2-829a-43af-897a-c2524cc28fdb@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 10:37:08 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/drm_ras: Remove admin-perm flag from
 list-nodes operation
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 youssef.abdulrahman@oss.qualcomm.com
References: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
 <20261029203000.1763447-2-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261029203000.1763447-2-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX2JmSEaTPrp5s
 5oCfSVumGbA4gGUjibQXCGPK8aH27ZXpOH7gjCXmk8sLJwTo8ZYQ612/ALqqOCx2/hP3ihYaykb
 7ff9wG1F9OV2fvHhIuEGePMRuGDTl0r4WdIwZAjT8VOYGgrxUYImBKnh20QUzAi/eRsKcW1OKbW
 9lLDW5iNB2FC8mBvpD3VGKft0Hv5DKyhTpBydDusBQzAbOp9186od3w4AcgiM7MbK8UZjkrr7r4
 caCkGYDeUVA0HzLrkpcRAw5NUZ/hic7l6BrjpllYgmUt7J/2sT3NiWzCYapRIv3QPr2A1pqol77
 2Oaq+3/E3uZQAmAONdENQDpKB57pYidclo46Sm3R+bS5YeTTArMUmmESx2pI90+GFj9Yrc7s0pj
 1R4wo2EE6rLxma8DOWpM8ra8cAgXIol9MltQHhlP7WQzT1mqh0SQVTPSaL4vmwPEOwK1Wnq/CO8
 LFhaliOFxsw6QGPwllQ==
X-Proofpoint-ORIG-GUID: M3PtPUeT3rRoPcYpStsRk0DwG9IL5JW6
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae4c7b8 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=rKidIdNGGuosbOtXPGgA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX/aHRLx2zYXHR
 NDilZ16DK2s5fOLEaCaoRR1vYGkfKj7sIqjsL7Y0teKzK5wVa4l+A/KKM2sLIe0J38IeL6NTNVY
 tQdOrOIvsxTq91ICMJfejy0zzAkwwmk=
X-Proofpoint-GUID: M3PtPUeT3rRoPcYpStsRk0DwG9IL5JW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300066
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

On 10/29/2026 2:29 PM, Zack McKevitt wrote:
> Drivers may want to avoid requiring CAP_NET_ADMIN for subsequent
> drm-ras operations. However, userspace must still be able to access
> the list of RAS nodes to determine the node IDs. So, drop the
> CAP_NET_ADMIN requirement for dumping RAS nodes so that drivers
> with different permission requirements are still able to use the
> interface.
> 
> Additionally, initialize the return value to zero in
> drm_ras_nl_list_nodes_dumpit to avoid leaking uninitialized kernel
> memory (especailly now that this function no longer requires admin
> permissions).
> 
> This prepares the interface to be used for telemetry by the qaic
> driver.
> 
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
