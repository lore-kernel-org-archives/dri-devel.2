Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D0B606A31F
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XOQcgXV9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EJ+4HNI8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C3789C68;
	Wed, 28 Oct 2026 18:19:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A559989C68
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 18:18:55 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SFAbnU1459114
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 18:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2UlnfjAbRNJJM1s06B3PfnT7wYrAZbMHSeL83sIth3Q=; b=XOQcgXV9Lj+oXRyn
 kwPCaHCeR0liIWmvAYjNH2tIdi3QlrLgwReaySAZ7kdCuADVmSQuoFTqTlO9Qpyi
 N8yV/UprUjvm11+IvtVi697FkkwxwPJdjQH4pHEFlDR9LpYcVgXi2hDDcpqpcAUf
 T8EzuWP5ddi3RRoRftoSo+LrxqCLB//+hoICVg00EE4rGZcVfOA08qHtVRXvlHhq
 w7mPHbxGjQNPZqFHw8ywbBlgUdZ5HPHQaa83mUA99X6TO3XFGhM9rn0uyCSYIyiq
 jLvvbeoMcuaWWb0pecbYS+ZYQML6m4d9R0vx36qVfynK1UCO5mQGkzK1rA/DQ2zz
 pSMiJA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk82tujja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 18:18:54 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b62317d0so3557112c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793211532; x=1793816332;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2UlnfjAbRNJJM1s06B3PfnT7wYrAZbMHSeL83sIth3Q=;
 b=EJ+4HNI8xCNQec+Q1HzmOxkTygKnJbkHD+hmpE/RxLcGkRZXlpGDbh+TFNDJxChru5
 MV70ICNAuca7U6GxTeN25HnIUdHVp0h2JtCh1owUDRf2Pq34fdOHvPy9EWC1tsFD1mY7
 Xs/09GPBmo+u0mMyRz1JbHPEjZHym86J2HKUig31lm2x/KBIMYObWLWI5/b7K1AKG/Gy
 SuP3JP7qNSnv3q/EBNOPUnGsXN39x/fTOwxiDghNJS1I0BAvstT3Iy69qCS3ybu4rJXl
 iS4/59I36o0B1es7xGDzfa1a1xdTOKbGoTurYbJlOW+rBqLuajM69Qtb2BSCLQFCnOSD
 SjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793211532; x=1793816332;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2UlnfjAbRNJJM1s06B3PfnT7wYrAZbMHSeL83sIth3Q=;
 b=VI/nHabH+EFRA0bfpASDCS7qR6EDUtQAYmv7EIIvOUT6brwxjTn8qZUgQMZ/KLPjf9
 cHqhkHdHRrVIaiCeWG+obDh/q+6dxLPYiQN1c6Ov122ra33kmOJpPayv7ZU8lL55rTec
 AULKSInqneR6v1ZnBlevjR5HlOFEDoJzQCcXiSkTQE7DMLkrLQtp/WfgPnDZe4jqpgzP
 vtJNcv+ftqBZudlz0yPwvwEavs2xPcQAY5JxpNHMjRnwIqSOwz+xuihf0dBZBL+RTdF3
 d7b2LljQhB503mfUHsiyyKJM3zzdmoWAn9vkCIKbc3c2Cv/63dSjpbgHcrjEH3MxR1n0
 b/mw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7AL/EVte/c2VJCRnVikfq7sHQ08deaTUn/9wEZwZWS1iPQG4yLEXLJSihXV5bfl8kxPF2clV1S+4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKW0M787MNzo48wxepT/dw3ZOV4v1LpOlCbLG0gxSEa3KT9IZu2
 r46Ov/sBZAQrjVJe5KXm2utlRuU7glz40o3GvH0LBnToc9zTJsTOZqCI1Xbgbu541cupIx5zguJ
 gYSOyOoLux+G1aKtclfrIDHEmgTbdjCHe4F90BLU59+nyvLqxFRMozwpELEsrpq4HIbW6kW4=
X-Gm-Gg: AYBFou0X8/+7cQbSSd1r8JfYkf/cULk58+jYNXnhnYGrDk0ZDOJJn5ffBOFkPUnVZgi
 nBkx5BeOhp9TsumFIP/zyNTaomc4H/NG65Rs3G9RmxGoWbKIe4yktqv67TBxaJ+2FMwJ/qMp+zp
 7Hues1Yx5B+DjnHe1g5T6alufvR8YJC6rBhIICbQD4YeJZgcZD1F+9+1Z8P+MysOG2avAK/T7N+
 dN+H+BDbMkFIirH1eyHcuCg2NgBhTh35TCHpS9S2hbfx7lweePUSyMKMzaj7H3s6YpPmpnW98BY
 4khfrhoNHWCpAtogX9IvWp4dSKumQTbWPSa8zeu3JMWeHz4sajUMCsH7YAgVYDXcgDPKh+xF3b1
 rGWw9+vx7GN81/n989MVIG/02+YZUQ+wM9NaXjvC/SBDxuHDJf/BwgbgaLyvPwAy41Y8EJvE=
X-Received: by 2002:a05:701b:4247:20b0:163:8b44:902c with SMTP id
 a92af1059eb24-1a6cced1a1amr4594462c88.17.1793211532333; 
 Wed, 28 Oct 2026 11:18:52 -0700 (PDT)
X-Received: by 2002:a05:701b:4247:20b0:163:8b44:902c with SMTP id
 a92af1059eb24-1a6cced1a1amr4594422c88.17.1793211531646; 
 Wed, 28 Oct 2026 11:18:51 -0700 (PDT)
Received: from [10.206.103.99] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75f7fb28csm9112551c88.18.2026.10.28.11.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 11:18:50 -0700 (PDT)
Message-ID: <687c4153-4a78-4ac6-ba88-1f3f818a84e9@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 23:48:43 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 0/5] drm/msm: Attach a driver to GMU
To: Akisaira <akisaira@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
 <TY4PR01MB140065214AE2B04B2A7D9235BA66F2@TY4PR01MB14006.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <TY4PR01MB140065214AE2B04B2A7D9235BA66F2@TY4PR01MB14006.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yJHwxxHjLFGZNExW2K6bvUBhqtcZiCVD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3MiBTYWx0ZWRfX/6+/IDbztBIb
 SHa05s4uBe28t3LW+aZw3lpAvzzCKkzK2oJEo+ZzQFkr05WEQnBgQ1HFdQdUYrzwg3Sc5awhybu
 +zUZ6Kx6yYVTyf4cqSx9Cu4jb/FnnK8=
X-Authority-Analysis: v=2.4 cv=Tr1zFzXh c=1 sm=1 tr=0 ts=6ae23c8e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=UqCG9HQmAAAA:8 a=ALlH8rN3-6IN5QnqSCAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: yJHwxxHjLFGZNExW2K6bvUBhqtcZiCVD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MiBTYWx0ZWRfX0McZZrrs9trq
 taofygRT9+P5UYH1IfufWkSRXroIAvQPy4LqaLUNkQaGkiQ99JnDki2xwVjOQY2VXM1dBoVQ/Gp
 m+JK9MwUqBTClQBEYsaQtyiLBh+AmEDiZmu3EeblwpljdI6sbZGR3u2dx9ijiMk0/29dSHef098
 oFBVq8RhGogBhywTYKmp8CyI1BxpQ3iqYFtQ+78ncjppig39S7GZ/4PfVc0bqu29vVfO5HqW5FI
 tIoe/XdfcqKMKccTIFa9oyko16QSipoEOQ9hvC7+JI5SQfGBJOQqblHkng0xgkANpYcRRHrEBUb
 g9WQS2oekJKtp2zymmVGOJe9743mBhuE7tW+hehgv9svIwL1y9fKuyYoCmeLPYUJJ7WALLduOO5
 /P4IINXKT7YrtLW3LbA4PR/AxJGdKabeplkXl9rpr9f0MwuCkTYsByQK06etotuYemdH5vUhmbD
 d3AzPGQaAXz4HG1IIqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280072
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



On 10/28/2026 11:23 PM, Akisaira wrote:
> On Wed, May 13, 2026 at 02:22:55AM +0530, Akhil P Oommen wrote:
>> With the introduction of sync_state in the genpd framework, any consumer
>> device of GCC and GPUCC which is not bound to a driver will result in
>> bootup warnings like below:
> 
> Tested on SC8280XP (Huawei MateBook E Go, gaokun3, Adreno 690) running
> Android, on top of v7.2.9. Patch 5 needed a small fixup there:
> a6xx_gpu_init() declares the GMU node with __free(device_node), so the
> explicit of_node_put(node) at the end goes away.
> 
> Without the series, GCC and GPUCC report
> 
>   gcc-sc8280xp 100000.clock-controller: sync_state() pending due to 3d6a000.gmu
>   gpu_cc-sc8280xp 3d90000.clock-controller: sync_state() pending due to 3d6a000.gmu
> 
> and six unused GDSCs (ufs_phy, ufs_card and the four
> hlos1_vote_mmnoc_mmu_tbu_* ones) stay on unless
> fw_devlink.sync_state=timeout is given.
> 
> With the series, 3d6a000.gmu binds to adreno_gmu, both sync_states
> complete without the timeout, and the six GDSCs are off. The GPU works
> (ANGLE on Turnip), GPU and GMU runtime suspend when idle, and a game
> session followed by five s2idle cycles gave no GPU or GMU errors.
> 
> Tested-by: Akisaira <akisaira@outlook.com> # sc8280xp-huawei-gaokun3

Thanks. I am testing the rev2 with some updates. Will post it soon.

-Akhil.
> 
> Thanks!

