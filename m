Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30C606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DbnG0unp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aK2XMpuI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632281123EC;
	Thu, 22 Oct 2026 08:27:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D781123EC
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 08:27:09 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M8LnNq3194740
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 08:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fgqxS9x+QUp34QYI9MO5rz8NIdDGEyzpsmrDb5Pu9Ys=; b=DbnG0unpk6sWpfqb
 IKvelYuVBi0BhugkYpcdHsRgZTKSLMa+LeObSiT/umhylgcTXscx8PZbPTwxgd4o
 e7x5J06rNzq1FGJHRy47TBHjyF9/9PD7nOrFIBgsWLmjsZSfMKiAjTV85sru1HYg
 rse1r0FdemHn6aWgtFbOH7it4YJY3givcAZuJ/RBtS8m9DLWp6mwjPcJ6ZufE5E9
 4+Hz9OIynMjXXSqX0v9rbgvF1qWGaYusRuSQ/c4yYpfhS3VpGz8xSIbb/9Y8teFx
 wVkLycmKEPIZkiMbY0nfaURhnbI6nxA6lumQQEGeviYasMcBkm9SpCuk2GNhXv2L
 LflWIw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq01f3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 08:27:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93edac5877bso47480885a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792657628; x=1793262428;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fgqxS9x+QUp34QYI9MO5rz8NIdDGEyzpsmrDb5Pu9Ys=;
 b=aK2XMpuIaIpQLuRb2po/Ybduklf/DXsxucfeGjg4K0ciV21QZR3qO4wntenxHRMEme
 /O9S/WOLwAcI32tCLiMWdGzpX41BzN1JXIe7TuAFiDm3W8+zteGd+iICL2QvnotjPvef
 MxlrZEAOL1HGcyHZfB4caZMWkZqLpFMZ6dTe/b0fgP3ZfSQMyX0q3Bu77KJwBUhQDDQk
 T0XLnWlg3hwP027IY1dq3csCK3oJWtvCQ0vVVQ9SpPnUCwcZxApeOUj4RNG5LFcab7qm
 tY8ELSpYpqAlVRixssXHQDqviG6AtRoCeT6tXrJNOrgVdtA1uhrqNfIzX795aK4Z9vL4
 bidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792657628; x=1793262428;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fgqxS9x+QUp34QYI9MO5rz8NIdDGEyzpsmrDb5Pu9Ys=;
 b=uHS1LMIhCt1OK1nikH1h4tt0DHIMqN++bFCxDV00l0hkmDZtTdq2OAj0w5C89AXONo
 iJMqKc7y6+pIJ6GC7E+zBnmT4iJ1sr0ll5b/u5560lxylBNfRPH0ztdB8ALXCA3KYXY1
 5QSXyOeBRBtmp6jk7gYK6GQY04pKaX5wMPjyAZbxFbxt+PixWlHSGJRLKts/Qor+Wpm8
 JmIUJkTg+nzAdQfFYQ4C/My68/I0MjpbkmgODesTWOVJNZ53Dbhrzmzes5Xv26ucGtly
 gVB3hJcFPfGJrw75UYqQgJ8akNtNsK7ppnEoRFMugjkVI0VxzU5D/O5PGqFQ3boyb5wB
 9CIw==
X-Forwarded-Encrypted: i=1;
 AKwUvByCid0TiB5mwGxkd+A1MMniCqIDxX8RkSSlfn0am3JXPf/nviQJibGe1IRRurotN1M/Y77sC259gxQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK68qvgh10yizdEi4GbyrBnKWFcYmmBkh4dpJFSx2AH8nn5vsIK
 Kb5VLPqf02yu6A4EL1AFib2NgjGVS2eiyoFA/621mXhSGD88JLjkOt+WW5qygXiqxuOjsvPmRlA
 bJ13BkhlpgLYycUpQIUx91F0Z1vyaSqPg8OmYf2uRzK77EYfyzpwcCxysL9VmNgxzwrug3ZE=
X-Gm-Gg: AYBFou1jj6BRgAcJ1H5CjsEdNyMJXs9TIaJ/Ma5qAfUPrgXTb+LY/X5sPXCuig6lvaL
 7Hfb9RVQva3yy//7Lwf9Ny/yALOHpmpgXl+yioidvpkQQNZQYlv+1tSGMEEabe8nxt9ghatcFZ+
 aGeIaSrBUOeT+Kg4ZiwT9oI3Du/8zmF0W7EnBTt6sWBnDVl5GzLkCyZ/c5PI1UlBs1hrll+kWYs
 +nfrKrXIYmostAYZONpOJzFHDaiWHfL2Ex/GtDuLApmXUTPMdRIZqXl645tSL2CsuNf9J86TvmL
 37QlHxW+YYnp4QJm6/oAK2SOgPUNLcX5GReDfo+Af4BphLyHzvF7zKp15fot+nQzl9QcQ6XEuAr
 8RTieqYaWtkJVIMRrZUnBDg==
X-Received: by 2002:a05:620a:45aa:b0:939:9205:4d78 with SMTP id
 af79cd13be357-93f57f96010mr971934585a.3.1792657627927; 
 Thu, 22 Oct 2026 01:27:07 -0700 (PDT)
X-Received: by 2002:a05:620a:45aa:b0:939:9205:4d78 with SMTP id
 af79cd13be357-93f57f96010mr971929585a.3.1792657627400; 
 Thu, 22 Oct 2026 01:27:07 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c468a61a2bcsm77995666b.87.2026.10.22.01.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 01:27:06 -0700 (PDT)
Message-ID: <1c8f4222-e7e3-4b10-8826-60de6dd89a61@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 10:27:03 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] drm/msm/a8xx: Switch to generated protect regs
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
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
 <20261021204244.67160-14-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261021204244.67160-14-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OqUB-JP_iGc1AM3bMPCuTaiZ6Ir7Xwoi
X-Proofpoint-ORIG-GUID: OqUB-JP_iGc1AM3bMPCuTaiZ6Ir7Xwoi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzMyBTYWx0ZWRfX8ig6qSa2wu1m
 PbCMMUXmBHA7EVD19HbYE6MTYvKCfFrtQpbz31qnFBL9ATjWv0J+8ep4dvX3XG9oT6uNHip1aMR
 9Ai09XSdqD6r44g4PyVLqeqCuYuLPzc=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ad9c8dc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=0S8MXAzXKKfm4D3irQ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzMyBTYWx0ZWRfX//LCfhJjvZe/
 Rjqe0tO7W51OhG4tfdc+BCC24eA4s79/bF65zEQiHRjbQtjCn1la7XwDMnED5RPnND38N3pJtCc
 C+Z9an0WLL+YuoRjT/5k2UisEVm0a834QfI+0p+ML4u0bHj0BPFpKRZBdzr9YQdgRqVqXMqdmcX
 GRmgtjDnV2OJ9OvXcDyqHC20Qk6umkSfTTSAUiz9yGeFqhIu9MvUTAfmyvsT6SN+R+edUrlihvC
 Oz0ZSdYv0pfsBXTSp5LNtAN/Wvqy78fta0LoPK7sbbluXyg6QY2aWlNx/DwBCvgbi825ZJcalMI
 PKGyLyQKkUeIyex/82LghAXnY6B9E/FxA0aIzEGVq3/qCOHFsdfqbY3Gaa8IHiBMUQC36T9aRky
 PpwwI5h9prozLioFd4bmLFoFgQdc9MsOJpoGHjN/iKybqjj930kLrkPh+v1peFz6beTAKgRJvp2
 +nvqKr407MAd7u65ZXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220033
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

On 10/21/26 10:41 PM, Rob Clark wrote:
> These also fix some perfcntr SEL regs which were mistakenly blocked
> since we previously just copied the protect tables from downstream kgsl
> (and only sometimes remembered to fix these).
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

LLM summary in case anyone is interested:

- Almost nothing carries over unchanged. Only 22–34 entries per GPU match exactly, out of 47–64 in each table.
- The generated tables use finer-grained ranges. For example, NORDWR 0x8600, 0x1ff becomes several smaller ranges (0x8600/0xf, 0x8700/0xf, 0x8740/0xbf, and so on).
- Several ranges that were RDONLY before are now NORDWR, or the other way round, and some change length. Some ranges appear only in the new tables, such as 0xd200/0x3ff and 0x20000–0x27810 on maili.
- The generated tables don't reproduce some old ranges exactly. 0xfc00/0x1fff and 0x3cc6/0x1fff, for example, are not in the new tables. I didn't check whether the new tables still protect that address space.
- count_max goes from 15 to 64 for x285, a840 and a850. The old 15 was already below the 47–57 entries those tables held. Patch 13 also adds BUILD_BUG_ON checks for all six protect tables. Before, only a810 and a830 were checked, so the old mismatch went unnoticed.

Also one robo-worry:

Unexpected: on hawi, GRAS_PERFCTR_TSEFE_SEL at 0x8610 is still
blocked, because the new NORDWR 0x8600, 0x10f entry covers it.

Konrad
