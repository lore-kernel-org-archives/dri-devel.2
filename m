Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62217606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PKLEFtZ3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dy+7SzDX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A7810E917;
	Mon, 26 Oct 2026 05:31:22 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BE610E0BF
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:31:11 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b8hE1908036
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pWiYTS5xlZMJkO9ffGbPW6SlUMuEk+RahN2CrYFfdU8=; b=PKLEFtZ3m5ovf/FK
 FiMSaP+eiXFmhzCrPKaLjzAX0H5Tx3jcBhuuNeQFH7I6DQwxw6WUsAdQrpz0fads
 LQt8mip8M/jYaKXP44NZYvkSS67p17+vFnjbsF6UpToEh1OcVRjRMdiZ4hmLvoMj
 hLWexFGoDUWXyLWBjI+s9iRPLgVwf/0XufgOS4scare6NtemRj2NCYUfF6dabvrR
 GWIOfwfB7pntWVMPQsUWA2cPVj7nsQ6EijXoZPBWQZOjbb890yonUUVAWvM+OKTA
 xV2X81H2C5N0PB8g2BuIXcep/le4omOlFjDxF83QvzZ/QdPZncvq6g/cu66ng2p/
 kyRKCQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0gmycj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:31:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ea71803effso28251035ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 22:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792992669; x=1793597469;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pWiYTS5xlZMJkO9ffGbPW6SlUMuEk+RahN2CrYFfdU8=;
 b=dy+7SzDXfAZy0m7TiCvvZ2kYczT8wlduNFvwdxI7ZLtKAQamh5jrcuZcWjJUWOVniS
 3guQicRxyUwST9WC07lGtREZ8fMHTP2SwFQDLztakWnDn2OgmsgiBXnJpkSiaBhEpZ1a
 tzcTaU1amL969g2EmUCnYsgmJ9bPrR0ZHd0icBosV07QpMI9YCiOn3A8zoML7OYuQSto
 i+V/wuW4BtxsPSzCuPSJ/IIcYlxIULpR5P1fEkimbMu2XMOrdiZtgA6Q8kURJgkv7Tex
 f3RW43dBESnbzkY1oUqHglSs/T7M0iJEAfM0j25k0JmXcBCkF6XQA4f0+sgZYcASyym4
 P2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792992669; x=1793597469;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pWiYTS5xlZMJkO9ffGbPW6SlUMuEk+RahN2CrYFfdU8=;
 b=JjyNI3IdKdSK3LZmwtobCf9DfgvUOdE9rMqbOBoR7sQuHQw0WnmBdy+M/45hwENODl
 I/YHXVfNp8WwdMAAZpF1D5S1Ackjyfoa3j4lTDEuHwtwc2DPynt/TPVaEC7CKPg5k5Wk
 nZ0J1a318mVMJCXC4uhakE5Yh9Yd4WrJc+SQ8NxfBZLpoisOQEp0h+9OwAgMVWwnvLbW
 6eMQ690yqK8kiIBVIbqQgA3Zxc7aaM+wG7XoNNDSPwnYh1Iw3mRVv6qNDE3oZD7966Wh
 Q7Cm55tgWD0iLFLg7rlcU6R8+3duE1jkamlUsbAiji8mrxt8kYHYgG4Ph8KmK6cFjH7C
 9oPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnH4M5JoEJGCnyeGbZoRLnfMLSy5f3gt9qsJv66mGbxOJaKa4e5dczq1yDOf+BpNTxMwVVyGeJM4M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJuqZQEmbVXps6kwg/EEBABkj7T5pMtN7g5ggI2zKn6KRerlHYi
 f3oZ8BHMFTlOF9k2c8uq4H6JaKBLLO4AoodTjT3qtablIJChfGxNgKqdxHkdA3fwsnHEzoFHRIM
 ims3ZFeMCATvEPXtlMeMicP+eTQnWQbUINgm0l5Ar4rdSJtk99ubFqCjtFP7j2tB5tphFQPU=
X-Gm-Gg: AYBFou0AfJXUTtFTT7he6JoAQ+qeXmSdtG2kPLeX/0X6adEbIVX7z35wq5UisLJpRyA
 /OaSa0HPvfInXXABbHdnag48ZNSIZ8sDfwRLtvlDa3rD/f+ao3C/gvjap+MqwmNka5GUdJpa/lO
 2Q/2oCtokMl2EvrArQwoaxER+A83QEeLI6cHlIlutMn75FbFsScm44vSvbRRVZX+Rh4/yQ7//Tf
 wka8vsNAj+6Q0QEp5RcEwOSkNC+ps+TWdJ21nBx9E11hyI7OiqaagDMi+plDUu2g3uWPBWvDJBX
 0jvQF/jo/n9a8ACI2GC9wjp5RdwgEymEAzSCwWpS7ycgMQwfN2xJqmOwGa1iHRJRtCJ+METVJ5T
 EPRV0tyeKDyHdrUbCmYUqDjJdF9Z5Dg==
X-Received: by 2002:a17:903:2d1:b0:2e9:9522:ed3b with SMTP id
 d9443c01a7336-2ea9c84b245mr45565905ad.70.1792992669198; 
 Sun, 25 Oct 2026 22:31:09 -0700 (PDT)
X-Received: by 2002:a17:903:2d1:b0:2e9:9522:ed3b with SMTP id
 d9443c01a7336-2ea9c84b245mr45565785ad.70.1792992668719; 
 Sun, 25 Oct 2026 22:31:08 -0700 (PDT)
Received: from [10.219.57.104] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b1dfee1sm11134745ad.64.2026.10.25.22.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 22:31:08 -0700 (PDT)
Message-ID: <5a761083-d031-4792-9471-93d013abc45b@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:01:03 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] arm64: dts: qcom: lemans: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-2-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-2-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EHo9M--YIX9TbOaIxAp45AagRuH3SqS_
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adee59e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fOTrkZ0PMPD3N0poT60A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: EHo9M--YIX9TbOaIxAp45AagRuH3SqS_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfXwt9+eifVb/Td
 JoA48rUwT+JNgWXcjHy/flAqkD/w39FckfsO+tD4n7ZoWuXmdPzxBv8ZJQHm8EYjj0MZCEv5M+3
 rLKMKP+uG7MZm6zIn6vkFj+MFbdg2EExC7QsEI8D2MP4IRKo9nHqWzOAnp//cR+430T+V5hqOZu
 5JelNyctKxf7xfpbo9rtTxPNrL/255wnWmWSeXqS9BV8KTUolD2rqqUdy8HzZ9lqBlnue2unsZW
 wg7iUesMVYaDtYY84cPNKPwzMb1Nnj7TOPBikt0C+o++Op3H9Mx86qfTmhYkkmiePi5MrSudRKn
 1W6fjtWlnOg9Bbee3r7kXAtOKgyJ6l+ra5sTXgUNY7ZUVWK9mfp8f3rywvPlAqARkvqxSiCfvqn
 KND4l+EFx5k2O0LtBBy3hvB0lAx2i/EITFIJBaQ6AoXiaWUOLjKWSMBvj1Id2Iahzgzbb0+qqkn
 3k5oU8p/zBqwhwAz2nQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX6b9j9RtfL1Zo
 LLfvXVcsvcIjX9X5tA9KqdMmJ2DOAGtkOKhWUUC0ND+4i3ssL3k/TLheW9Q0+n2fDkkPENjdSNP
 xKijzfSABUZ6jmNAImQXWDDjgvZGPrA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260021
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

On 23-10-2026 14:33, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from Lemans device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: f7b01bfb4b47 ("arm64: qcom: sa8775p: Add ADSP and CDSP0 fastrpc nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
