Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900BD606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JPV8hxT0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jiUPB/rO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0735210ED21;
	Mon, 26 Oct 2026 09:53:20 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E8E10ED21
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:53:08 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4ahUc1708828
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bYy/Jwyeow/fBLZ5IOY3qekzGxtgJZYPejsTaPKV4sQ=; b=JPV8hxT075qsg3T6
 mEcxbfzWO/F+1sHvbdS1G5qtSnMINA9fKtU8iq0N4eX3VManpvgZnx28/OYHsPKj
 0nWtMhPFg9FZDl56IzqTpIhLJI+suaIMFsJTfgyKMoSNkceArzFrt4rkp6DQ7nzR
 hWngJCzomXAwMUOZ1sf09waCCAMS/TnD5lw7+DYp+8X53Sw9s1xyXKIW+WZhRfs+
 xveOSkrSw5FhyipIoD5ksk9iNWegn8G2JnPAH9onQ6PsR5z9XZnmvKaGt5hkt90o
 YXfdculLyMcNh1bPkAGA7A/EMpNfbC88TYpbujRGi/F7XqoXiOIT1Z7MJ0vumpBG
 zxxciA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjd9uu9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:53:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cc50fb0d2so44459585a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793008387; x=1793613187;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bYy/Jwyeow/fBLZ5IOY3qekzGxtgJZYPejsTaPKV4sQ=;
 b=jiUPB/rOW5OPJ0QkC6ha7IQG/X8MGdKLZ08Ajjq6wixBX9QQQa0nQBnTVDYw02dgSO
 rYfIYBp1QHRom/0DODU25X0s6Jz9xE4hobYfvq22gW1obyzPKL9zW5zcigriMtBJ4CbC
 PHUvgVz1+7QqD5qwbm6yUwr1NOfyyRpL6ASFkbarOFPbPhJNdKXuDQIAf62yqxvYmZGX
 JxKGgCwhHOD8mYb23k+BVDVcWvkEivhP6QRWsyl2nLPMvu/NESEzAJWa10Dh6gz8d6KD
 o+L6GRUAX1S514rcCUW1sbun9L5zyl22VwrSd52czIdLncfgZ3fzNe/QMBBoOAOg0CVl
 DA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793008387; x=1793613187;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bYy/Jwyeow/fBLZ5IOY3qekzGxtgJZYPejsTaPKV4sQ=;
 b=2BxMdZex0Od7MorQe86zvzn+nXyPBEe0eg0cUfoMGSTKnoCmephgS3C9zqkLrhFFOU
 4NJJGBqoTcVbd+hOBIL9qCMma4iDvygMeX3nY44wGd9VBDidUuzEZmqKKROLOJDEIJuw
 yjADsLZcTb0JsDmxEIdF748QkrxHyNSBRzrzLrzx7iMyeQ2fvrnngxIWlDxG3wWXy3zh
 +Y3vnwWp6veLBtz594cRQsOhaomcuyGxZu99xOHCT4FzU+Y99+RPUWZA/kGZwNnzjI8h
 M8CUaY+8zm1s5TgjcgYX/6vQRnpkd0iXdWu8B5L/f1G/w+XjENjcSWC0g+DLbkrJLPhq
 YT6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvUQL61/CnyNCAxa8zNYYtT7IFs1WX1p1D/WOf9Y+xZoxzz+yyLA8Lu9prlZtnjubPe13O66MMJ3I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIM44UkxjeqCkgSYF4FVqs+U7iAJ8EHepJuvMhp4qM18IF4xeNa
 zeWYpAriwABEGd4WRj1Ad4O9QGgxQ+8ixjaYEoVBd42oKLbn9tZf/tUXHIsV65xDy1IWZF3cKQ4
 fjvPUfTLM8Qy9HqhHIRu0emwERrvemKIq0Gh7UTv1o/Udx/Un0ok3hW/D1NoDjmeGXiyC1vs=
X-Gm-Gg: AYBFou0Zg5iwqXVg9ezuYhkOlygxhxFNxT5dyKn6COfe8IsMG94xKLLHCEoZAjkQw+c
 njIQHinsQTf3JNJEx5YHCna4gMY2s/V8osk685W2ene3Jkc7ziRPaIvjgwCoCj4h+JOn3I+Xmu4
 ofp2sMQdGeAoAD1Yl/CmlRm5NjgAyLMQV0T1Tu13Ruzaf740rTjtL9XvQOxgOGJkzIeCoLyf5E7
 gCHTaPQwLxjMDIr/TAay4RHjdMYaoGIMSpx+b0/UAm8UDLP6OlM5lruKkR/d6pSUH+W1vAXTrgg
 68/b0/vAC/EImLsNV6QPJVdAydUfKY/Q4y4KBTVllI2X9pIxhjkcB2vXrzI9Zx5mw2QZMOh2iXY
 Eah/Q/4LtdzE8EU+8j57usg==
X-Received: by 2002:a05:620a:26e4:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-940ef8ec03dmr1010422685a.3.1793008387163; 
 Mon, 26 Oct 2026 02:53:07 -0700 (PDT)
X-Received: by 2002:a05:620a:26e4:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-940ef8ec03dmr1010419485a.3.1793008386690; 
 Mon, 26 Oct 2026 02:53:06 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4e89e6sm304007766b.20.2026.10.26.02.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:53:05 -0700 (PDT)
Message-ID: <13053ef9-0301-4db1-a9d5-1cdd845866bb@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:53:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drm/msm: Fix sched_prio inversion within a ring
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>, stable@vger.kernel.org
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
 <20261024-assorted-fixes-oct-v1-5-2977f974ddb7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-5-2977f974ddb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KwmW8UTx0dYtDc4vdOZB0qkC2sjQ7XpL
X-Proofpoint-GUID: KwmW8UTx0dYtDc4vdOZB0qkC2sjQ7XpL
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adf2304 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=TPaDMEC0OJE0i2k_fPcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX0/42vS5BMojF
 +TDCJlXu2tQRi4dPCwF/Y9hfpuYOKpEZ4RAWibcC6pJQsDfGJ0qy6Z89fijIi7zfyfq16QB4cW1
 /z1ZvLlrA6Tcus4u/Z9sow9Ug83rP00=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfXzccPTNAIvUyx
 veeMCSk5WZV2gU/RfMZnopfkpmGf8NMg1gtRXEOMT+GAC9DGpsn+yWiK/nui3HWlUWEQR/QMfxW
 u5GDZn4bP8ybak3rokYjmcSdznQ4QVze8cqfknTkGuEden3qH0U/55zKSGdVdXjsP/Q4iwjwNdq
 CLDlkgu3+SjYnZqJnDQFJ8yh14mGpYD2Sv9+Mi2FIvtwBCfrVY2tBGhHzzOk1By7cRA46IgxkWb
 bGz5gwwqhTCCkCqrgcbPhxDJBrmzNBkg0+EmSyfPeGu8PBNCbhdJGVevz+RQEx+b13HkdxRr0hv
 V9onZsyIeptdO4hq3wqUYqBGtNS7k/ubQuaozRc2mVwtw1u33Pq+O1i/ihD57TX5hF5D1q/XNk+
 +EsmzDAyM7BhOOsJECH04V1lpwRPO+o6y59gHjeig2UaNsOCgS/ohtXQB6d2LRhMRy5szwF6QOp
 v+8OnKHD9eLfyeCFsPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260039
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

On 10/24/26 12:30 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Commit 38f922a563aa ("drm/sched: Reverse run-queue priority enumeration")
> reversed the values of each sched priority. But it didn't update
> msm_gpu_convert_priority() to match the new order. This results in
> incorrect sched priorities within a ring.
> 
> To fix this, remove the inversion logic and add an offset of
> DRM_SCHED_PRIORITY_HIGH to keep the range within [HIGH..LOW], reserving
> KERNEL for internal submissions.
> 
> Fixes: 38f922a563aa ("drm/sched: Reverse run-queue priority enumeration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
