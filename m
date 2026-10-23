Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3A606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kJQsA8Fs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YtpOJBjY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54597112A19;
	Fri, 23 Oct 2026 08:14:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8041D112A1D
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:14:02 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FKFC1552321
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tqv4KAoTYY3S/U2JwEiFFAex7twOglJ8WJnUqUg1DcM=; b=kJQsA8FsdDYDXY6i
 a7Kj2LAxWDzNHdXqTYI8OUen0oHwtkYY49xBoELPc7nsS3cmskLKwlLSQuMI1Sfz
 PQ8/BdIr+lSMLozM6PymdpD5dU3HjuHwh4a5XIRnCtneyZgq9dsjQ5LKU9PZL3gG
 lefv5o5fY+/kjDHBCB2iMrXOQpZpJRVbfwokoURV/idtOFD0KAO6VLk0sZsUCrsU
 5tneIsou6i0pqjtKPcEW8Ajev5nljBoxbIg9OCcyzjB1wSvh7gkwUVCBr5gQ8H54
 yDjCWahkVkHcW4MKPCMPHpVtBndx3L+ZDbwKERK5HP+7uOTs/CY8sT858z7Pr4Ip
 NTGnzg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmttnfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:14:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad704d4760so663415a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 01:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792743240; x=1793348040;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tqv4KAoTYY3S/U2JwEiFFAex7twOglJ8WJnUqUg1DcM=;
 b=YtpOJBjYTPd36LZWfF3jgXZTjgR0k8HhwuG2YarCmjBrcSurkLPO8ItR+1eAnDICQo
 lQ2fOb66eIerIZsQE+U/E/h2deAOIluAslOvlwBTvC17brza/wWIeZ0JzVLcJzJxeKrY
 tCxGTELyTeP/YGJtYeyxeR9B73oO7ItTgatqxEU2D/ReMICqK0ASElO7ddY3iNBOn1nt
 1p/8Yn4QzdLt2Q+mqHRPBFdLeFOpx2eR97HrLqsvumK498iu9JnsWfBp2jsW+B0oUc9c
 alyE4lwR7k7z+T0JYu9L+7YhTCZdRws/bfLWheNd8JTI3HzX7GpaeWgtA71u7LxdV5oW
 1p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792743240; x=1793348040;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tqv4KAoTYY3S/U2JwEiFFAex7twOglJ8WJnUqUg1DcM=;
 b=1QYWMso+0JJvplP4w3Y4n038X07oFRK/DCDX2QvzptdHuuowA32yBvm50kgBfZ4ylJ
 PSjFfNsbg2NlacGedZAa6RXbw8fJJpbcQYyKg6MMgN9tpTXWB1txuMLYyE0Of4wOPiIY
 yV/2+X4/d51VHbFmgFqJ7eFEDVYmtvSVzlbaQOODbqvgyubbC2txAnz8fGgzpRVEOjuG
 29SW3LA2IW83cnU0awU7BlZiWn+y6BtxvTnyy7lpsApDj1RalaJv9URnwDhg9SEujvUe
 4fHJMZmmcaFuyjEl1lXEkLLUjVq2NQHDRAlfbpVNxvGpNk5LclkD8hiL++Cw4zLUHHwB
 uRbg==
X-Forwarded-Encrypted: i=1;
 AKwUvByVVBkgzF7Y2KJ6Uk+9Hi5ILPhp/3iPW5sb6WXXVCreZNzkFHO96dq4JMrF2xdPSQkBbv2NNhnqF3I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIQDSii+7WCiPbkkJWos+yBjw88UjNYZMmjU9hY4mxKmbrI/U+C
 FRdB6FWpkg+k+3qFaZdrkJhY8R+CQM+H75me+Zq2zVNPOoL/9WMzXBd6D3Pp929GM1bMGKO4ckR
 aTUHbXOO00O9XZ+nS6jD6q/C3XUPryuRAnkffc7WlLD3dm77n/BALrHFLH9MAYueFZ9xho+I=
X-Gm-Gg: AYBFou0sdqqxaXHfxEmsg2zb3lkEZ9XtUy8TpxgRfLBxAh0j4mAoyd5LVxtRVKqs7Lm
 xQcfSZt+7OUZf2FU5wPcBUe/bngxlrCjYOmL58glwSTqB+0olPK17tXpICyydJJvrlUxVp056DK
 CtIqtx0DXbB0BMqjCTQGJhfSF2Ei5Zp7KJQmBk/o5/r9fjrj3WEyFi8Vw0GeFcRAF+ZHoo593r7
 sTujxIvnmOhdFjIo9r1QUJQeMfMd4nFf2kuc7jn/7C2oprt2YJacDql4CDj37iUiL7hw/l2HwHm
 ne/EURLRxLxGi/E8CCkqXlcs3+yANNNoH83zVvZQ51sL7iBdWins9tfYioHAqTs0F0Qch6WsAhU
 a25oCHg+m6fFU52yssemN1dK8JMDIRgrzIA==
X-Received: by 2002:a17:90a:d40b:b0:3ac:8ee5:e007 with SMTP id
 98e67ed59e1d1-3adce616026mr940554a91.20.1792743240430; 
 Fri, 23 Oct 2026 01:14:00 -0700 (PDT)
X-Received: by 2002:a17:90a:d40b:b0:3ac:8ee5:e007 with SMTP id
 98e67ed59e1d1-3adce616026mr940524a91.20.1792743239783; 
 Fri, 23 Oct 2026 01:13:59 -0700 (PDT)
Received: from [10.204.79.28] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4954979sm7758959a91.17.2026.10.23.01.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 01:13:59 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <4c4e48a7-5ece-4fca-9387-a50c29bbcc83@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 13:43:49 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] drm/msm/dcp: Register DCP display pipeline
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-9-48aad0fe4f72@oss.qualcomm.com>
 <b2cf0c52-4c31-4b17-b341-029b82ddbd7f@kernel.org>
Content-Language: en-US
In-Reply-To: <b2cf0c52-4c31-4b17-b341-029b82ddbd7f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb1749 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=_vtLzGX-cFUddgSYHekA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: cG-fpxbMCyGx5MHyfTyrFdgic6G4e_XP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX32JUkiae8IE3
 TOya6jPAxFR1qJBp8wyC0o2bcPIvsg9YlH/g0A1iM8w5wf2HFBli0EZLpsVHNKUi+8ETy6cjXzr
 G+MqFGfbgwy1n1t6tzOdXPLjK7hrkkD1XdriCQvTZpTj7hrUve+UKKJKdukhzWendxCaLHYLV1U
 luqXRxM/sKLbIKwYvcppfB3L+dHDZ0ve1dCxlcwZsNCz5gxtOY1h2yr0/daI7afCgTMLd28rELX
 AX6CcMPHswspodyPCrYrTYP5SgSy9V3dEqcfOm/ZR8UKfJqXsfVlMRXANMgTxjPfLlv3Sjb6+6E
 oQNYBswUYHnU2NdeVM0RMWG8opmdENA0mG2YAyqZec/q8zPNOxRd0zpqq2PEg6cRB749xKOhg1p
 E8EJ2sox1bwbDyOMFtZk9sp9wAaTPljAsnuCXkXLhwO9uVOTDn64TlM5JcSdc7xgNjfYExtU6CS
 UTvHT5Q/mF5V/2rtomA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX6g8SZWUP+LP3
 Le1KDivxD/Fr8vKIBpBurl5qbpvWEIv8PxI3pwvB7PFJUoiSAsgd4TLNHE7Z1tC7f9OR8+T+YER
 4hSod4o2tUdLT+CVeSOs+eRc6kfLLhM=
X-Proofpoint-ORIG-GUID: cG-fpxbMCyGx5MHyfTyrFdgic6G4e_XP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230032
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 21-10-2026 17:35, Krzysztof Kozlowski wrote:
> On 15/10/2026 09:38, Jayant Shekhar wrote:
>> The DCP firmware exposes display resources through capabilities rather than
>> through host-visible display registers. The MSM DRM backend therefore needs
>> to build its KMS objects from the firmware capabilities and device-tree
>> display graph.
>
> ...
>
>> +
>> +		remote_np = of_graph_get_remote_port_parent(ep_np);
>> +		of_node_put(ep_np);
>> +		if (!remote_np)
>> +			continue;
>> +
>> +		if (!of_device_is_available(remote_np)) {
>> +			of_node_put(remote_np);
>> +			continue;
>> +		}
>> +
>> +		if (of_node_name_prefix(remote_np, "dsi")) {
> Where did you document the ABI?
>

Will update in the bindings in v2.


Thanks

Jayant


>> +			if (dsi_idx >= ARRAY_SIZE(dpu_kms->dsi_bridge)) {
>> +				dev_err(dev->dev, "too many DSI outputs\n");
>> +				ret = -E2BIG;
>> +				goto out;
>> +			}
> Best regards,
> Krzysztof
