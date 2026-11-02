Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DEB606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZRREO1QA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bH0g7Fzl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF38C10E5BD;
	Mon,  2 Nov 2026 09:44:33 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D860E10EC81
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 09:44:22 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29A7Ia3430613
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 09:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZCa/YPK9ZlF3OQw519mYhFypdJ6PeksxTIjOEMw7euE=; b=ZRREO1QAjeVOSxCH
 lv9RJxZx6z6iWF9jL2zBA7cxtzVayVF4tRsCazMYPa+gDalzYovZbrHVdgmEDcMQ
 4OPdDGklBAzv/3CWt69NSeI9TW2snsq7uT3+LzIMxkol2Ny9jnw4bGF5Q0Z2lujf
 rP0ICGltYROVYVALb4AbHFg2/9QX2K95et3GiThuGdJe4Ykt0ZBq3O4W8czAYtXE
 /XUX5lgx16wyZZDLPxuxB2TQCP01X3NAN5WrZQ2CDuHQBWKKZiVYUFudXd5wN0uM
 gGW1IEm8rGkc1hoTCpv9OKLNKx26fqRID1BlAhS/zB+XknvZ7WociAJwoa26gSej
 mwAL8g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpnmerp5c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 09:44:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb1091fffso29984685a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 01:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793612661; x=1794217461;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZCa/YPK9ZlF3OQw519mYhFypdJ6PeksxTIjOEMw7euE=;
 b=bH0g7FzlTvdVLapXrVkY58aql6w0NJh6NQKcRIcpqM4YHI2S0cZxbj9qpXnb0W5t+k
 aaDCK1xOMk/ucitJyJXyccvyMuG0fmyY22QxC7UgE5uPwZWlVnWiTZSMgw7bY4EBKC8P
 tw7YuVOC+yflQuBIhJtE7gAPcAGN3BSb/8RHYQSzcMheeotEGMLeX/vQ235+MByybFPi
 I2FFilnJia5KmsXf+RKm7jBhrym8jLj9i3GHYv6xiKMOBed+FCW3MlNkPe4ab3HYwyyd
 nZXRgRKXqXB/kT+wQ4WlhITJyaJDPL1XIZAachANPI3GwmlPjlVQzdD2LR1seouxaowV
 rYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793612661; x=1794217461;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZCa/YPK9ZlF3OQw519mYhFypdJ6PeksxTIjOEMw7euE=;
 b=r0iz0M1vAxRh9WPj3BRFkYgCTjBxw620c0ieYodhBhhnxSlwoye0BGA8kC4BMtaxSA
 +mwUadDr2cNgAoeMYjvt/t5pZFUTvX+XpigZDwBf6dV/BbiK7UrEU1LmA6VfrSi910d5
 doPT9ZHsY77Rq52MOZv9z/99OYZOamzE4kxz6FP9bt1UHoLt8aqkYK/QOgyyfp1gmbOA
 J59WbjQpKb36GKs3dI5o4UYorje68L4RdmJzGWXUTb12DbwShD9YLcGLcry0FLAqOcG8
 fRkM1mwgdlXE2S1pP/GApc+uViIuC+kjHJe2CkcqJblFJYur+cX+6YSr25xv9GLkkao5
 iyqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwODszgRklcdpeOCgflx9jeabYqFIR/FiZ7kMYD02ZQNpsakSs8Mpwry+TVnhcK24tcpfGSH56fO3o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIOtPVHjkc0MDwMZ9fSAxYrPgO5pX/gIUQxnv/TabZ+OK9Aib57
 DJNmbIIJ6a4+OmwwiO2SFSOzHWorwJccMoVYxBTsSPFo8zpbh60OJ2xYg1K6gKWKcGahigaMuaL
 25fPkNhovw9VHXgOVv67lJ2f33vpW+Uu3dBkwHsa5ZUvmHZHykHWyxNG02RqSC6iUW1xiBmk=
X-Gm-Gg: AYBFou3foHLgCM3yhmz0tpo1vBbL3Oy06MDmVmTTftBOtsOmWjztvsD3fQ2otoKkJFO
 40GQvRxWPsH3MmQ/A5GO23dzDcW3Hv9VKQw9iUpxv19W3qgBts6VE7dxFuxFQGJXC/ftVSFd6EV
 chuTUN+RiWGc18thhcDrFvB7p4LCGtxvgsVQ58tF3e2zc/bqqF1nNUfh/PCWzSbXPiWJZMq5OFX
 v124K1hGCOXi4mMuV/1wWK9e7706sdzPqCjAWnCygsGEvbF0fH1oVUMg1VTpPNvlPphsn4zqqJv
 2YazfbrmakQVviby1cpTBBLkY1dvHfXmpasa73/G8RFHGuLAjjCdnjdYvcZNB4zTP71q/1WdP1a
 jrJNlDPYRMG6nvvQGbZmCdKPrAES3XSR2mdtVEP3ZpG4RVE8Uva2udfGSCdj9wrKrnm9k9dk=
X-Received: by 2002:a05:620a:4d0e:b0:939:8148:1e3d with SMTP id
 af79cd13be357-944215b76dbmr1780540185a.2.1793612661054; 
 Mon, 02 Nov 2026 01:44:21 -0800 (PST)
X-Received: by 2002:a05:620a:4d0e:b0:939:8148:1e3d with SMTP id
 af79cd13be357-944215b76dbmr1780536485a.2.1793612660576; 
 Mon, 02 Nov 2026 01:44:20 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4ec9a767esm3081382a12.5.2026.11.02.01.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 01:44:18 -0800 (PST)
Message-ID: <6f842ef2-91d3-40b9-b22b-365be4c0c6ed@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 10:44:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drm/msm: Decouple IFPC disable and sysprof
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
References: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KZ1HIgYD c=1 sm=1 tr=0 ts=6ae85b75 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=e5mUnYsNAAAA:8 a=D_WMUv83azVPUa-0ShAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfX8X1vBnFUDeT+
 Ptq0rgZsInbXHzJxMrZhFjvX837QE4aEi8kCGfZ3pR4YgTdW+NxlXTOW59C8m/l6CtAziYGAAmF
 lcExpdRz1nxKMdEXI0mrSBV9AouZF3mz1E988JTtGUE3IIlA2NEF2I7YKMdLwnbRrDBalMDS49J
 tRk3yQH7a2g94k5ZnEfJ16qO4aK2rYwiF581tBaOCbKr0FHZXujtHXjDk6164pJLrYejcdgU4j7
 TC+7whvuWflQpCZvZWyBOg7hEsz+zbUKxRiQgLZ4ha75b2HIFQxU2TunHIULcqfHWKxjhFFdFL6
 C4QVa5AXVn8/lJ+I5aisANe059JtnMpqKzk4dOlVRcTYs5McC4PtXBb16xG8aeAtMJE7d83Yj3F
 QQnY48Z4J/mnRqHyP5/cZGwXTWpygB5UwoBLQmxEYB/4Id0okF5dsgiHlrI7JFhAFHLEzgkUS0a
 PVjLclJ86AEznUf+A4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfXz5DTZxO8jAn2
 ir1fmEzryvHOFaS4zk2eTTurtJ9YbB5NkYO1vIGIO8CCpuNEQX56W2I9ig/LdmkUjjyEsB+rGtT
 RER3Sm5Fum1AFbvwRurrylbPihhN+yQ=
X-Proofpoint-ORIG-GUID: eBdsFsB8ZXPus_We461-dfyBjd8iv-7R
X-Proofpoint-GUID: eBdsFsB8ZXPus_We461-dfyBjd8iv-7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020038
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

On 11/1/26 6:46 PM, Rob Clark wrote:
> Convert IFPC-disable into it's own refcnt so that multiple threads can
> request IFPC to be disabled without stomping on each other.
> 
> Extracted out of gen8 GPU state capture series[1], as other than fixing
> a missing IFPC disable in debugfs state capture path, it is unrelated.
> 
> [1] https://patchwork.freedesktop.org/series/176505/
> 
> Rob Clark (4):
>   drm/msm: Rework IFPC disable
>   drm/msm: Add cleanup help for disabling IFPC
>   drm/msm/debugfs: Use cleanup.h for gpu state dump
>   drm/msm: Inhibit IFPC for state snapshot

Sashiko has seemingly valid high-prio comments

Konrad
