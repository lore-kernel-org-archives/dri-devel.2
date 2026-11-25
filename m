Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD31606A327
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bV62D0qb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RpUfjgak
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F0B210E10D;
	Wed, 25 Nov 2026 10:54:53 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97DD210E42F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:54:42 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mSFT3764057
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mYdA0Lu2qjNo2evtNJ4tXUQFqZz6hfshGFjdq5gk3CA=; b=bV62D0qbmQ5GPMHj
 rJcyDrWn+tkh7KG08A5zKMU3C4XHwCAcfkTKnmhv6PBbGw9cex7IhehX8cxY6ycR
 ijxOCQyikQCjvohpG+kZQJadElCe5mqIVJ67UooAn/NbwU0SAwCGt2LQa3Ak8C0t
 39rfbGd+Xq+/9/p1aHDl+JMyaOox58BcGvjRFl5Rm8BEEqxnzEMTGmNPMMgsn852
 n0mbNS+gy4nzyzKgCOUAp2GXB+75mWciQwVvxjf4DxWOu8y4E+jUBQq0Db7LtoVK
 gOP+ZvBQsUuSN72MZXUK+OB3K77L7iedI+MIhOLOnk4eK/6DdhAeynUWS7VCYThY
 lMmrAg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vv2re53-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:54:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-55cbd8c22b1so8502121cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795604081; x=1796208881;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mYdA0Lu2qjNo2evtNJ4tXUQFqZz6hfshGFjdq5gk3CA=;
 b=RpUfjgakXMcu4xfIUIsKP2dSEB09k3JDFP/f/hJ2lzp2UKXpBmpFhszBoMnx/vbl5a
 KW6sOeh2p2ATbaucvLa2gnHWUQrFgIaGacvp+dh7miRajC1piC4hZt9/DozA297Dtrdn
 1NAGky4u74+n5sGOVaWUCtdMYsD5kDfvOBJ/Um16tSX7u9vliDxTTl4VpUHb1J5DCTp9
 8Ow8IamBdr7IGTQi6V2F74M+YboI5Irv2lQhqqZIVJjMGsLyLG+GydspOKQjNjlJXEDJ
 U/WLWs9YV7MITz5WzaRYvtDtQcpVaNkuSv+AjJwHUYf7aP+z/F6eLS3QWNZ3KYtK6nCe
 NKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604081; x=1796208881;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mYdA0Lu2qjNo2evtNJ4tXUQFqZz6hfshGFjdq5gk3CA=;
 b=MBFeZC2B1lgyyqDo+lC98Jyr/cLao0zROGp3RKgZHFY7xbugmSZcCS8/rJ5Afk1jYF
 hWqXea4d2tX1cILfGMwdC9+nvpps8z22EN+ek7CpPc+u92TPUkCAPmLbrXpOw6bGyRby
 /pnok8riDmZcCJuW+Z4lapOv9+BqodBJvPHps5kBO4UQVuMH4w/qmoluN2xwl9awiRz7
 91IZKh88N47mrfQM9gslsAD+29ugVeEKBOPfm9J8bt+nRkHUtts4CBlD8w5laYl5GlgZ
 wReEx8/++Wtg7lEaRJIiDLoPL0xofFfkkM5zNYiv8fNzeBJ9TwPktq8VyoQTa+0EFDNW
 FZIg==
X-Forwarded-Encrypted: i=1;
 AL+hErF6xZihmlkOFzeCjzYB1KVYr5bR4zCTrIgpLovcqiZoF3TOfEnvXVvg3GQMmZAXrfPvSDkukzl0kL8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9CbxsNWovkaxL6qBa6rdTqhMmgh2L1VKgZo3IHJFhH11qW/s9Y
 YrYOwQ0CP1LgBBNsD6gIb3WSvj/d6vwDBE01OBa9Bi2GXvNG2pstg7e4BF0rmTN2mcJshwwJHHV
 CxiR+DFiTScH9aT9oPa9mDoH5fxDD9TQD3rUcZkAQW2o/fhn7RdDb9BI5wL6YwW8zdoQLtQ4=
X-Gm-Gg: AZFdTZeyKnu9fS3RgpvCBFcgpWG4MAahuUdzDNqCX8Z3zmKyfIh9VkrpTLTOzSNaOCy
 UZX/yUwdIAQS3EVcJ0Bk5oNrFBVMljL9fxDsCq6nM6UKZVh9rCHdJvTDpNTRBHrSUFzRLIBi07K
 8X5tOAl40wZkjQj71Y3lVI9+dRwBBWOvoRlTXSUJzuadWCHVmCDO1+WxNjR1mtP4zYP585ExAVe
 FJpCeTmLDCqwezZnGYnqbX1BZSEa+v5xQB+UaktTRKZmdBjF7nP78s36NwG2wKTpOHpY3P9XwyI
 fW3beouOQw9L6b/D6aQhQKNBEJGDVjgYep0ntCIohJ3y0gRWCOkvVKm0LX/c/EWLtBKklB2pl6H
 KBP68n6yjUkSaHeyg/lCgWqX3bTykT62k8uHppVljzRc03W7JY3LwKPfFIKgxqJRQYdJzW50=
X-Received: by 2002:a05:622a:e447:20b0:55c:b745:bcc5 with SMTP id
 d75a77b69052e-55d76884627mr307731401cf.1.1795604080906; 
 Wed, 25 Nov 2026 02:54:40 -0800 (PST)
X-Received: by 2002:a05:622a:e447:20b0:55c:b745:bcc5 with SMTP id
 d75a77b69052e-55d76884627mr307731081cf.1.1795604080410; 
 Wed, 25 Nov 2026 02:54:40 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba371072f6sm8191977a12.28.2026.11.25.02.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 02:54:39 -0800 (PST)
Message-ID: <9472d897-6fce-417b-b130-481b6b109f66@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:54:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: sc8180x: restore dp_phy_intf_sel on runtime
 resume
To: robertijtsma@gmail.com, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20261124-drm-msm-dpu-sc8180x-resume-v1-1-a6201f43136d@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261124-drm-msm-dpu-sc8180x-resume-v1-1-a6201f43136d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MyBTYWx0ZWRfXwog8j7vqNpzM
 dqKkrGyF5jmM+8k23sfniCoJZIriNc2ZnnnC24JrWUXibL1yYcnI+l7Rufn7nNEUWuVM2wyS2id
 o9W4n19rNSCK1eKYVutXPJBo82MPnXw=
X-Proofpoint-GUID: e0d9DRlUVWEYU6_HDSs01djfP46Tg26P
X-Proofpoint-ORIG-GUID: e0d9DRlUVWEYU6_HDSs01djfP46Tg26P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MyBTYWx0ZWRfXzRaqSieeZqda
 VBw3pD9zUGVDq06sdXulwl9Wkl2sPFDYaR1OSGNd7UwV9jgJc8JWsppfq+ND230aXqOcWUnvaMW
 ntaw9a/0hGtCQrV7ynR2eG4Y/qACpE7fzcB5dwKjN3VX1IWjK8PlVBcbvUyjMhnt6LwhyAGmYM6
 3a+B6+4t8zDf/VcxGXgR+saeLyqDteQt2C7JkC/J2M8/0enTKXpyL9kBx2i8k9V4eRhDAx7VF1o
 37xGOj1IJu+EGoWa3pnRJ+vkD34UPh7pvCkBRpzkUNOSYrtt8HBapxSP/W96DxTVBZup8aAFFjB
 +rraf5SJAdRh9m3QLZaDVebPI2gQiVjm/bbGnrE1CJJFgZ9GkVx+jvGrJ4bH7d5b3qINzHOCSzb
 uShN6oyApPVzL7Y0w1Cqut9hyYXfx7iuaKZZvNPZ8Fz2RWyeBGW+9FWYMnoOAG8gkImeb8BLq5J
 n2RBfQI44c/JCixRpwA==
X-Authority-Analysis: v=2.4 cv=A/z5rKWG c=1 sm=1 tr=0 ts=6b06be71 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=SvDnwdDAYdV65z6mAxsA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250043
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

On 11/24/26 11:46 PM, Robert Ijtsma via B4 Relay wrote:
> From: Robert Ijtsma <robertijtsma@gmail.com>
> 
> On SC8180X, MDP_DP_PHY_INTF_SEL is currently programmed only once during
> dpu_kms_hw_init(). When MDSS/DPU loses register state across runtime PM
> or s2idle suspend/resume, dpu_runtime_resume() restores VBIF memtypes
> via dpu_vbif_init_memtypes() but leaves MDP_DP_PHY_INTF_SEL reset to
> zero, misrouting eDP/DP output after resume.
> 
> Factor out dpu_kms_setup_dp_phy_intf_sel() and invoke it from both
> dpu_kms_hw_init() and dpu_runtime_resume().
> 
> Fixes: be3415c620d1 ("drm/msm/dpu: Configure DP INTF/PHY selector")
> Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
> ---
> Restore MDP_DP_PHY_INTF_SEL in dpu_runtime_resume() on SC8180X so eDP/DP
> PHY routing survives MDSS runtime PM and s2idle power collapse.
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
