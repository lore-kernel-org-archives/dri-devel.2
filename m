Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274BF606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=laYZx0k5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bavHWTD1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A72910E26B;
	Mon, 26 Oct 2026 05:32:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB3C10E26B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:32:35 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4bbBE718659
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pW1samNYYT64bJe09RAe2TapYHj86RTpjxKKlwrWwCk=; b=laYZx0k5KqM6PnvO
 RGu6cyNnyeLJgzKwlDEdTnQgcq/Y4sjc4sRnknyRgAc9JYmnd1p8XBqr9xZK+PV1
 8vx/RKGXni6cpjgJyURTz9ejj0SrHBiWab0RQ5Y4VakrKH+BCXCrLjTVUx5xnV5p
 CyMvwkBTuWFo33OMcQAHgPw/wYY/divzGgo4Urrs6NNb78aEoslHtqrW5xEw5Ud7
 gAmOwlepjnUHb5KtqdpgsGkHCn3hneaCQtcX6D8KK/zNye1k7HwOpEWPzoRN5uoW
 p2VL3tmvv1Wci4tfQabZx9CbiPSJWAKyJifwfxrHhO0KkhuoWKc36w9OuJnl80eU
 Hk/E8Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsgsry7m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:32:34 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a05b68f851so3318563b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 22:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792992754; x=1793597554;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pW1samNYYT64bJe09RAe2TapYHj86RTpjxKKlwrWwCk=;
 b=bavHWTD1pBV/rJw431sY/K49llOFPvjQtILvrjr+/1KTH9+08OLcZPZiHFE13cKpM8
 aaokAJ6afRl/LuK5QfDp7qu3kz2UujCiUHVB0vabtAl2pkDCYs7QNNHUqQhVS+XITUrQ
 TLty8kq2+lZHg68hY33M9VIHx0KiNwrZmlYGVbQwK46FGaWJpWBk5YrwbnZiCpdkLiVD
 zeclGTtoWYn8DWZarvWzteoTpOTP7TV5ICCNwQsZqcASEhKQPoYmCirxmhN4BIO1vlf6
 9M1YhI1/pv5soG2FHyE+0oEmXJKH+6OnFngRntKXct97Q1VzMzP3/cmqBgbIZMWBWZZd
 76wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792992754; x=1793597554;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pW1samNYYT64bJe09RAe2TapYHj86RTpjxKKlwrWwCk=;
 b=eVgVc2ArM4p/9Z+14mQlBxFTMQd4Fzmq5yqq+gahAOZzLlmyt1z6qiOjzQSpulpVuC
 rzRdL6Tl3vG07H6p2VL3d9+lBuSbwKPDTIFG/fGyW5SY97Jg1elG9Q7gVsHMgqGBHe1P
 iSfVdK3mv31D5yMIoIGsej2MilwMv7ln9Eiy8qappVWnWeXgDyn2bbw1HlJBtTsjiRPv
 7nns7jbdgRD3FU4ekofoYZTWZrlo2lVWpOS6wZ4bq7oO+4exBZdFXLheFSDcOsQi6kcp
 2OGMeSP0UtRkSFpQHkgGoX5sG2VBWm9GabuqzK0XGkxMu4e3+m/aemvxf/F096Db/xOE
 285A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbmkofKRTb9GuU6ET8bgLwTjz2dQfcgtO9hpE4N6I3CXNsHD3mJnGEc+aD8XVCp4mr+DCRQDJqo6I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKyAqYC95P63OLkp03gJaA1Ap4drbYX0rbSWoChZg/sltmT5cGY
 LFQuZ4dGZlJDz54HzZ+iC8SgvAcST6H9W8P2DJwT/9TeGo3PcCxXP5Na9nbVOMDDce9iSzMq+pN
 Ww7gNgLbBz9Izn8SoX6lF6wV/i2OyzS+CctHxnEq3k5Ckk3e8xVLt4NP8UohEhsXJ6dL+72g=
X-Gm-Gg: AYBFou1UIuprpubOw3e8UsvqZ5n89NXlsB4IOhG8zC8rmHFUkoYKlxdXKImQpfmXHl5
 VURf5PLQzphjISBJIysBgNlfqe+ApUua1qjYnF55BBU8CjqW8Pg7Qds6bzRirWFP4FfhaijAi42
 zSk3WuBdHLmMIoEe0ZJgBnbwnIsQvObPAhbPUeHyttYM9TaRVMwxy7hqSqEbPRfl1AMZhAySIJz
 v7ElEJyqgZKUGdjLwJ+x9bEEDRibtJ4oa8l9UbWp3oJAKvVS01L3O9VZzcat+rJwmRVVK1oaBo8
 LYa/K61iFXVYoAfkj4nAz3f09L3PJPyKculNunBXyKq9Kf/Xf5bwdx27P+DT+DvsVYzxr0NIjDC
 OipRdaPM9V9ZDvqfxe6ygtstKgPC1
X-Received: by 2002:a05:6a20:548d:b0:3e1:d72f:4128 with SMTP id
 adf61e73a8af0-3e7c0f3df1amr4025293637.32.1792992754239; 
 Sun, 25 Oct 2026 22:32:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:548d:b0:3e1:d72f:4128 with SMTP id
 adf61e73a8af0-3e7c0f3df1amr4025281637.32.1792992753812; 
 Sun, 25 Oct 2026 22:32:33 -0700 (PDT)
Received: from [10.219.57.104] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8cccde306sm1046860a12.30.2026.10.25.22.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 22:32:33 -0700 (PDT)
Message-ID: <594e0a9b-32cf-4b0b-99ce-a8e92cef580f@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:02:28 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: sdm630: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-6-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-6-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX/2HJZiMB6es+
 aaY9snuDI19Kh0iqMMqlo4D9TSmYjv2c8GabR7nF63zpDoOqf4bi92uI69FfbDCi2irSw3oGwd6
 eRQifqIrx7JQgBTBu4YA7RLI6xnC2uI=
X-Proofpoint-GUID: WaJHgWWuSF8oTCiiE5ZTeHIEp_TgKcc4
X-Authority-Analysis: v=2.4 cv=c+8+0h9l c=1 sm=1 tr=0 ts=6adee5f2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3XWmBZFTJKG1aVtgwM0A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: WaJHgWWuSF8oTCiiE5ZTeHIEp_TgKcc4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfXytQV/FO3zukl
 2fjYPwhiqQ66cwMeZQMLZSBFf8lPrJE0cZrgevIKpU2S8Qu1DoOZs+EwNQAc7JEFZyPivK4zt7g
 SK8sYMLckdwQ8YV/ZVm0zFgiDlooRHm88gX61yqHuubLQRCUPoitUakSQlIVJEWAh679ewAz0N2
 o84Tl9bohPl0+i5i4z4XALi8AtA+LEysE6BGG7dsUqwpbK54fiDTqXVwseuLt/W49QYINtu5kfj
 zhe8DT08Kw2Sth62y99JdbnohwPuWpsmWi5UvXksyud5d1OM+lP56KXWwQuyswNyMfzww0vpbDn
 lHmhntB8vNWyFoVZXD80RofcJlE7ruKmq8n+DnZoscDMEt70DqDKzBSG23xV95RntJL4trYIo3G
 62f/IQTAqPQMOj+x9TrU/KvocnHHwOwz3TUb86VGDxcUJ3NnG+mvIikK78dgXcjXRGvjpZI39ef
 ilTdFFK7RmX9lMXWx+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260021
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
> Remove the compute-cb@9 nodes from sdm630 device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: e8e1fb5c703f ("arm64: dts: qcom: sdm630: set adsp compute-cbs' regs properly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
