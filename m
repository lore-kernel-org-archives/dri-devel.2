Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C9606A333
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AqoUVJ/d;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TzzE5fuB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C952F10E7EA;
	Tue,  3 Nov 2026 11:34:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF05E10E7EA
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:34:13 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AARQ33161930
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 11:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 maurfOk4cR0ueAIurI11kBg56ZYvTSPe0M+xFKXxfJQ=; b=AqoUVJ/dxBv4VgJR
 hreNW27lhBeJqbDR2aGvdFn6GgIwlabmn0rlabfPbX4e8t0LOnvyYdwUVAxCZmjZ
 Tm44HSDuZMgeN3FMWBE3KizomIQx1ckXtqNuu4cfEkk1JRVl6NlHDvLcIFgnDukA
 qqBy2wBnU8eQsxWJWZgeOu6Ujled71yjpbP15eOaL8Y76ni5hgjyVscKiOhceb61
 p36gErY18Qm9Eevb567PFH6eAaqFf5ZUpzNitRVm/0ik+FYcl/tQgFjhouJviqrS
 7CFs03CQgQNSVYX53ANs31qrYdiGSjL7BtB1ZNEMkbT3W+MRxG3lxkwT73C38+Lz
 6oZ+oA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m9a0rp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 11:34:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92eebb130dcso40035585a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 03:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793705652; x=1794310452;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=maurfOk4cR0ueAIurI11kBg56ZYvTSPe0M+xFKXxfJQ=;
 b=TzzE5fuBHMJUBoi2GkVf3z1UVVg6qF2KkUZ0ghSnV90xjcfdYPc814AxwzoFc0dn3Q
 joK8GaoU0KVuEb1CofrE8dI5iec2SrSfVWjqY7zszSvHvXIV87CFT3Iv7Ig9UM2sGR0c
 umw1aE6lRfE1hrIGLTXabEMqN45qVAjfljw4QquOJ+IS9nWDr2T1HQvH/Y9ebHi/OX3Y
 X+uGob7cRPh/pD6H9xsaIKuL6nyO/YuTWWPy0+sipjBSTy5/2iE8/ybsFC001fNPUOk/
 mlDUNPSbYq/zBAZ8l1HDH92i7eiVzlmMBJkwDbPF77DWwOvvQhkAs3AACqfJcryvwWD8
 q2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793705652; x=1794310452;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=maurfOk4cR0ueAIurI11kBg56ZYvTSPe0M+xFKXxfJQ=;
 b=cEicQgEVlavdyZGB8WZm7i2I68LdvyeHfnot+16w0yhvjBmD/zWu8GCTW868dhUOj6
 NbUiqfH0h9nteigMoiHifp6Pp89U+7MbvFaXUDB2r+E9fShDAQVeI3llZsT1KY8xKwRZ
 0KWQjnK2i6AJ0Ddb6DZDHcF0r0ZSHn3S1r6xoUCFc6eTejjHIWPSIs6m9SY3JWKSuhc1
 7red31Dz2OE3XXexrkBFUPlfG93m3fR0Y9DkIHzGDqnEHN0jothu3i57KHvaN8+qRwLz
 OQn3DHSguwe9KJGRFZcSUz1GH3caImgVdKKrt6GOzGad//gSQon7s6VtlC+0noucd1Go
 QZnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7q9MGKmFjScTIzNbNzymzRS+H6ID26i0tp6frj8i0K06qszlhd4o6gOxp2BdqPHxySsa0roPQBZo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Ii/bkcF46GORaVwNCl4Gzayr5/SYnzi44Cl0TNfv7/j6stQn0
 tk2pH5Kmi1xFQvqRap7YTiJpro/mS8tH62EmzASVKgGQUFMT1F2LhJ7tcY67IE4zi2Ltm2mOCBq
 9UAGnb5yF5pv5mvI7YmpeQh6YM0vJ4Tsf6+zbKk0e04Snv+e2rEmhPm90dH7kWHLQtWY0CN0=
X-Gm-Gg: AYBFou3EoDW5u5QgUDITiOMWSUz7RrgkzG0Gz09CHnxn7ZLpwqaT0iPjIRnLZUSpD2j
 /e6EhXTkYpuDGgaO90EzEGrpcVRiJyoZbmFTcbSKRlBEpxmB4/Ehbx3Q0l4F6kfVxqBCvx7sFfx
 gGPG37iWi4fW/HZCsLI330vogZYyFXwK7+ajVBelKNp2Ht/fyRo+fz1cArbAM1qE9cwcDtvZ2Z6
 uhsfz7I+/VcIss2LaqfJGTAoFtimtaL4jCmTkd4KB/TMqzFNq0jgfjtEsZXKvJ1/2DYKWUfqKhc
 wKYZdXO81+CY/T6I8qq4fjINdNsDEYgV+W3azkZ+c+d7HNufgCJBjakj41gicEQj4ML1CgbavW5
 nuhXx9Xt0fXbq5CXweItq+QEX3GhXyCtk1wNsRdNsJhdaVbZpaCruGmCGm2OKHSuGDV03Bw==
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-94421666fadmr2304380485a.3.1793705652174; 
 Tue, 03 Nov 2026 03:34:12 -0800 (PST)
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-94421666fadmr2304376885a.3.1793705651744; 
 Tue, 03 Nov 2026 03:34:11 -0800 (PST)
Received: from [192.168.226.81] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cebec0751sm77048966b.26.2026.11.03.03.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:34:10 -0800 (PST)
Message-ID: <4974e205-c6f3-416e-ae31-eac2d8569b1a@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 12:34:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/msm/gem: Fix VM_BIND range check
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261102172001.508440-1-robin.clark@oss.qualcomm.com>
 <20261102172001.508440-2-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102172001.508440-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: elDLoxR1SoNyTO5190rL0RIO0XZrCdZy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX3n5F+sWYrZmK
 k27G15d94YS0L+uoTvS00asH4Cc8BG4dl8kebzk6GSIwjqOV34eUo1bodH5HpaUEYY2oMMs5G2r
 5/ReW65oUudlQOj5W0+LHZMv13McLC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX0+bSin5w3YaB
 aum8Whk7ovMf5vr42aT9SIX+AkHppZcBIX5/gG/RyQWw647GZrv3WfumE7HA2MdByEJxeJQSiyY
 vxQECCz32WzvsyGmL/S+77bygPAC4dyrKRTuDXh+sJqxbnZKf8wLI0NZMCk9QFev0hJtTRA6q8m
 kOUUwlbqVAcJWjOEdVoFgIu2rhnnf18vj7kk09rualNh4bTRNsOoCBq48hVovhUg/WASSKQaT5S
 qeIgpgN3PaL9j8/JB5deV4oQWwYuSOMCU8He+54/c7Vwyr8DqQwmst4jx709mqiJpTJlCVkIKUy
 oWJtleTfKIF5U38c93rAMUwg+jEovzBktBFO0LuIln+GwPoVv7GA5hvPqfrB0PZSg+bnmYuPfrA
 aB3pysK1zLXnhqnGAsXHxJL8p4CR5j3uTYtSdUcWhbBcPL65rPY0l6cOqQ0k4L9LJCtxO+TocAb
 8D7cQrKe+hxHlto3IHw==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6ae9c6b4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=chFjt-TYfWtG2qqLwSIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: elDLoxR1SoNyTO5190rL0RIO0XZrCdZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030045
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

On 11/2/26 6:19 PM, Rob Clark wrote:
> Use size_add() to guard against overflow.
> 
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Fixes: 3a3bef68a6c1 ("drm/msm: Fix missing VM_BIND offset/range validation")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
