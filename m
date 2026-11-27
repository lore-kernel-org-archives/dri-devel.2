Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6D606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l9fEWqg0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YN7Q0Doa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3572010E351;
	Fri, 27 Nov 2026 05:45:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F2F10E351
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 05:45:45 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwkC4162579
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 05:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hJdEygyyrDZ
 KJGb3ntvQ0LztTs/6r0XSlN9gAYA5XxE=; b=l9fEWqg0QdnD1tAWX42PLnHSY2i
 yFTCfIUsuD6P7I9ypbRcnFPAFNC7KCaK6u4B/pk+g/r58I2UHeKnUf7Hl3zEr/+r
 SfIMH7+2AFypRsxAFi4lc/agBayNRpJk0z1FIeRIghJSR2GXwf3RaHmh73VBMot/
 MeoFLPGy8PsQyWKOloHJK2mavUn9j2B27P4CY5xrd0MfLWyhMyiYzCrBILBDDWGP
 M57hp8mpfhx2d14JggeOQpbpRXzN1U6pW0GcKOJ22Hi1EG1bPsc90/8/GRyD9dVI
 iLllkB92uGQyWPuKm9ONTT47DFkMX/4ZwNQ+1MUyQa1rhP6pgfSYU9aukKQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6h7gbkxd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 05:45:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b3f3e256e8so7242238a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795758343; x=1796363143;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hJdEygyyrDZKJGb3ntvQ0LztTs/6r0XSlN9gAYA5XxE=;
 b=YN7Q0DoaC0TOEBTLxA6s3oASrZWVvzzHWgkh6Z2HVsdhVuxOiPpfZzBUpYpwgyGOZD
 ghYY0IYMFwBY0D8/jN2zCZ9sNJL+rOqhvpmBI4flgOKgEMCkqImyo+MEABbVBsugb37L
 Q8FPVFdYlXk5FcwvBjjN94a/Xfc2lwrYIUAUoOJ0auKwkh4whT4g8AahhnSqnkaN8kZM
 k5Q8UIdvTIqsYVidARwPRTfQx+zlNlEW/bveI90s8WLkrs8d3KObT7B2jF5BxHUgJFpR
 w6b0SMWCFzEGBMgUWrF40CYEKHQ0cnPRlySJGWExAtwfxE3XKyQoMc3xCyGoZpzub5Ef
 s+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795758343; x=1796363143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hJdEygyyrDZKJGb3ntvQ0LztTs/6r0XSlN9gAYA5XxE=;
 b=YVqWaKoPFSfl5mw2Lj5bgGyWSFIjJjVLGSmEOHKgRQEX0ooAoWKGSb6fF+G76NZ8wF
 Sodm2IEWiM+xAAljd6BqIUtdPNWYX7U8oxv8V17Sd/fWi0tAbQQobY8d6qKrrzAjLSRW
 1XaXevtn94dqXkREQhwVBvPA5Y3xU2TqTWQkY+5pp9TAjcaD8IJm3767+Rnk9QhHoqYu
 n9Dbqkfj4WvcU6Y/AlkqqUBRLK/F4FdaXHp8ubPSHD7uQBldDsAKz1f4N0Joe4WhXHVx
 dbddC2eyEz5tIZXQQlFAShlUdUREHdRZOH72puFA2GA+mwhlfhFAZTDLj2AcEnVc5QqU
 nNsA==
X-Forwarded-Encrypted: i=1;
 AL+hErGQloUCre4vB5X9xTM5xNf0ixcIdF+nPZXpOAw3AUTIl2rbzafpnf7g3rfzN40+fH9URLeGafdVqi0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/P3qefFWSJEG9s+BjKja6a/19EUD92FdXEYbHmmLFt5ieKxQYB
 aMKEhEyz7SoiqA7xb4q5C0n6ZiBvA7Wwsk8MnMT/2sNivyqMbzZ1x0iQcgVaHzmGy6u6Wu+HJj3
 eDpBjeHr94VadkKUfeKzEEh7anwhRcpj+fqV+WnRB98zIKUWWoxh8aLYMbJAhjNg4RdiGh1E=
X-Gm-Gg: AZFdTZdb7Glolah1nHAiph17+uLGhTwPSLbTHyT/+60HogMz7JFl50spRWkF6RnET8z
 fDY/POaju6nMo/Xr7E6IsWR+rvXjT8D8oB5/htTUx5Xxq331LQz3gQf3WJs2Ulta03VztTvdMkv
 fcFeL926syVwwM27vHIsJKWT7z0nqBz1c+tRiSExge678POnE4kVuJRQ1R06l0ZSDr7P4Qc4s+9
 YhxA+/weUmQiWCQ7jczxH6m+wsbN9P5WaucYLJA8f6nS3LVHjAE/Nn5BYuiD69lfOG9l7smgC2Y
 v/W6sNu5r/LusyeHM39IlWec3LbhhjScKQQcZPjvKA2K2IIpRXsfjX7NVRakarw1sNvV6wLaxoJ
 tr42Uu5oJBn5jqgPsU1JFFBWO00Q+oIrXFM8uZ5Id10FoENjLZNLmJE3GsaJSjCi/qDoBY0A=
X-Received: by 2002:a17:90b:5287:b0:3b4:402:b3fa with SMTP id
 98e67ed59e1d1-3b41c8fe1edmr22183514a91.18.1795758343109; 
 Thu, 26 Nov 2026 21:45:43 -0800 (PST)
X-Received: by 2002:a17:90b:5287:b0:3b4:402:b3fa with SMTP id
 98e67ed59e1d1-3b41c8fe1edmr22183485a91.18.1795758342617; 
 Thu, 26 Nov 2026 21:45:42 -0800 (PST)
Received: from hu-anane-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41adcfe23sm36124198a91.15.2026.11.26.21.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 21:45:42 -0800 (PST)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, quic_bkumar@quicinc.com,
 quic_chennak@quicinc.com, dmitry.baryshkov@oss.qualcomm.com
Subject: Re: [PATCH 0/4] misc: fastrpc: add HPASS domain support
Date: Fri, 27 Nov 2026 11:15:36 +0530
Message-Id: <20261127054536.646943-1-anandu.e@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125-fastrpc-hpass-support-v1-0-cb1d46b29e3b@oss.qualcomm.com>
References: <20261125-fastrpc-hpass-support-v1-0-cb1d46b29e3b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pkW7Bbihp1T4kA0uZIkWvXmqalxqjvVi
X-Proofpoint-GUID: pkW7Bbihp1T4kA0uZIkWvXmqalxqjvVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAyMiBTYWx0ZWRfXyDog9+xNYc9X
 3RBHALAW5TxMc4zhr6M66nF4nLt7V0X1eVuVP0VQBykoT/hRDfOG9OnTHOVVzWa4vz46so4jy+E
 c2anhdSAmbgrBsvjaOiGUvp+eh27SqxIXhxzSS4+QnnQab1Aurpt16e73C54CGR/av7A+U+MobG
 B7lkj5VNvnMglf4Ayg2yy9l0uozEipNbxD9djpJTJr/LM1FwqWLwGEaDXJkiImjYSepSEJtuP/3
 4Nd0l3ijrQHez7bWrMp8TRIHOQKllAYHSgIkAhEwnG4EDMOQ12IN+0Vvs0KqhM7mqaGVeYW3tzy
 RO7zZTtXKD49LV2D/nF/pCvVMrI81ZLkiPOfN8RSFET7R+yq43tru7F5T5TGIfVNwI75BMvNA6R
 tC/nmWAXTzN2yrOy1RlE+OXC2pEceSD+yPkxRY/NZc47RyESZgoNXT1NTKGG8xtGV+pqJgwH2N9
 fdB8XZY/zlmr4iY/dig==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAyMiBTYWx0ZWRfXz+Y2xzcaWf78
 Ljrwifq/RyYFe8C+uf2VzgibwxBEivxJjpoJwbsE6Ig4THClGVdUCOFMOyMLYM7oSQO2Z4hlS6g
 6WQW/bEgxdCVGJ1K5k+7xPUefInRslA=
X-Authority-Analysis: v=2.4 cv=L4GI0OT8 c=1 sm=1 tr=0 ts=6b091908 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=HMxxIxWglf0TOBfGhZcA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270022
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I'm dropping this series for now, will revisit later. Please disregard.
Thanks for the review.

Regards,
Anandu
