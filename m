Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F6A606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AnJR1bnH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QFva4pPV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E821112856;
	Thu, 22 Oct 2026 17:23:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E5610E22E
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 17:23:01 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MH8jeF831305
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 17:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w/BA3y2OoXjXB3mySNw0ub75AxUogb3EEtu7UNqKMkI=; b=AnJR1bnHub8n2Dsk
 PlaY5Er+I38a5c0bYq/NZXNjg7beJBG4/NmYYsTdv94f0/U56bmbzORFuNIni27f
 mZUqsH4R409pIXypzUTj0cix8G/DL8Jf14H8onZHRyakrjOoHAYpFR1338rkEoB9
 IK/DLvMRa5C2LGfpH6agh4GaOZtYKl2kgYkTRAe0wjwkxBI5QQ6baEehFn8yU5yu
 MWTDKXHaAQE/Lh+sPpnO8TR3v/AjgN/8cq5g9/TwqtcLb/QU533yvyIQvOEQ9IIH
 voohru8LE5vILX/FPLNiFCHOFaiBwmzUnE9H3gRl8Wdh/JEBQY015K6tMhuAaKWr
 Xj6DFg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ccv73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 17:23:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8a079256596so117808b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792689780; x=1793294580;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w/BA3y2OoXjXB3mySNw0ub75AxUogb3EEtu7UNqKMkI=;
 b=QFva4pPVE7n/vpZwgeAJrAO3NdiWSPorY//0XehajRvqUj2YG50WHGdqvga+lgioVs
 mi8yrhpNK/rxlBDRjrSSX3O05OhbsSGb+sQTLgn/fV2otu/BESRqABbSsaqtI4Wo7FG1
 sRJfMg2gb59JHy5w0MTPxfDOpPGUG5ojSTh8xxuhgmaz1DzgJ5jTHPOAwnxXtrGEnisi
 QE6W10IaV4rtZJKSOVUDiPemCqufp8l16LJWvmwn3UwOXAXTn6g7C4a/bz7WMZtAlxJj
 P8MLXL7ZA0NkUEB0sDKy1NlhnRmQIYsxU3cvLErS5NjhzTPGf/JNBAcAVWxeBVzxdIsF
 9dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792689780; x=1793294580;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w/BA3y2OoXjXB3mySNw0ub75AxUogb3EEtu7UNqKMkI=;
 b=sxRqaT0StZ0qYISJ30W4SWA+8doQtsVK5jyfmfFGdBUXGSAvUljTYMalYPXvipRhDs
 cihAmymffgw5ku1Y23GkhV6BPaL+lVuiyhh3Ky/HMpBM3WrPM4j4K09FN0GOV23YcTlS
 Cvy2B5odyTMsrsCUwaU8k6o61ZaHVgFphmsCaBFmXqPwIa5aMxPFoLcc5L/YAXdbWMXf
 G0xRihJj+cIUCvv7jfK453ECgMAQ3udfyZDj/pvUdfiilA0Z41tJ8/4figb4QmiYArVj
 dWXIcJ4J9AL4brsbhpThsPjSCyN0+A+xtktEwGQtHdimPLbmA1b+91C0fgP5gWrnU4dM
 d+Mg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHH9qKzhR4XCTYltlLOw0Fx52cyjkafmSZRGM4yZo9fFbqs3Nr+oKTKb0Jgj2qTvJsEWggVib2A30=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLCFZ+thFE3WiijnyQI0F6u85rBsuWCapCwLkAWMrZ4u/Vg5Xgc
 51Tk0kdy7En7uTvsyuVDGg8TJwjTGVnwTAmi/2t1h9xdGid2cxEFNgY1csv843XQylZgzWJcbzl
 shubSWCbUJWmYgA3lU8v69K6MHGX6OGjz+CDb2yvGLav4dQVCqAnTPnFyO1Tsf5jymjO3fFE=
X-Gm-Gg: AYBFou3t9N5gwLhxYdipH1N3PzBlMZiRc0wCjITf1nvkqj5aOd0IpmoFJWqE9VG8ekk
 H5kKXLNa4uJX/C0yvI3CwoLsj96PfHr+Kig8EDIKDR/Y/WjPsrrpiHcT6F2zEYm4TZ7MtTjhXRy
 8utEGy/hERzzRxNa6w54Yu6i7omMkS/NofdxKeRnv2+QA3fXd3hSnw/YbtbuBCDVBVKVjVaMzk7
 9oJMjz8KCgXpwL7AW+aF+vkftADFBNRNFoe52l2z52J7I3hnGhpdPMaQVeKjZWCLzsaFktYTVp0
 sAGXmwAPwgPpwfGTCKB3S7HjgzNgt16GSjcJOSSIYdrXFgSRCDR4aN0Uro0qOGAIeeY48UQ/O1k
 F5QdAJ8ymF7dqa9KoWQpKfXlUwJnTJA==
X-Received: by 2002:a05:6a20:3d12:b0:3e2:117a:62ff with SMTP id
 adf61e73a8af0-3e287e96620mr5159371637.61.1792689779555; 
 Thu, 22 Oct 2026 10:22:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d12:b0:3e2:117a:62ff with SMTP id
 adf61e73a8af0-3e287e96620mr5159351637.61.1792689779003; 
 Thu, 22 Oct 2026 10:22:59 -0700 (PDT)
Received: from [192.168.0.195] ([124.123.194.175])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a0895fb005sm2450502b3a.49.2026.10.22.10.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 10:22:58 -0700 (PDT)
Message-ID: <22a87c51-4f8c-49c0-a13a-c11767f10e85@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 22:52:53 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] clk: qcom: dispcc-sm8750: reset the MDSS blocks at
 probe when the bootloader left them running
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>, linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
References: <20261022140811.469417-1-xiaqinghuan@mail.ustc.edu.cn>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20261022140811.469417-1-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2OSBTYWx0ZWRfX81NHGCdQJfRi
 GyPphojJHoGA7/3gEwVEwJBrfqyY/w4Phl9xoV2ipV7mDre7UZ3xnXtuz0M1cAIV/5gxCN4CWPk
 j9LQJ4Do5vwZ9lz0FNuyEtR61zwNE1E=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ada4674 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=b4qShTKTPH0tEwh9VF2HSg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=rTHtfaqMoHADTYiKZ3YA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: RP_lWn8q8NfJC28SrLXva4fr-rTFIxg6
X-Proofpoint-ORIG-GUID: RP_lWn8q8NfJC28SrLXva4fr-rTFIxg6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2OSBTYWx0ZWRfX57yiDW4uF47b
 I3mtGZnkZ4zxCiS49IH+QfHYaKQaopK6UQs6/qdWe8JHA4FVE0rbUmPxvvBga9gAFDnrSJDz0ne
 jbxHomEAqbO+54viuIz1Na4QcY+uDd0p8g0ARKAkibIcZXN9QKFSClQ0CjgjZRPJJFBKENd/vJV
 jxGrBjGY9juUJNg5gPCe6uYp7v/v9TvoqNQ2Q9Gs/TRqBUIVOMgCGoiLIW7ktBUgAY2VUnddoRS
 JCRrGtOwYGMK33b1mQypD5q7LV2yA5NMpzrsOQSPIl784/efxYI7W/x3dTm3KKb2knLlpUwGQcB
 nuBLaYSksi/phmOi6J2HL6uQXxG39d/gR7zBl15DlqP6qdfFgfFaFiIaiUzt0BtVbJPhI54PjgK
 3/8Qjvv42mhwvb8vTboh934xYW11lKSyacntvze9g6UKFworngIpWjgLlMbJRAL9PaNtu8FCrS4
 B+ff1twXcwakkunnTlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220069
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



On 10/22/2026 7:38 PM, Qianhui Xu wrote:
>  
> +	/*
> +	 * Some bootloaders hand over with the display block still fully
> +	 * active: dispcc PLLs locked and MDSS core / core_int2 / RSCC out of
> +	 * reset. Probing on top of that live state makes the command-mode
> +	 * panel fail to initialise (command DMA timeout, panel init -EIO).
> +	 *
> +	 * Assert the three block resets and release them before the PLLs are
> +	 * configured, so the block starts from a known-zero state.
> +	 *
> +	 * Limited to Lenovo Elden for now: it is the only board where this
> +	 * handover behaviour was observed and the fix verified.
> +	 */
> +	if (of_machine_is_compatible("lenovo,elden")) {
> +		static const u16 elden_bcrs[] = {
> +			DISP_CC_MDSS_CORE_BCR,
> +			DISP_CC_MDSS_CORE_INT2_BCR,
> +			DISP_CC_MDSS_RSCC_BCR,
> +		};
> +		unsigned int reg;
> +		int i;
> +
> +		for (i = 0; i < ARRAY_SIZE(elden_bcrs); i++) {
> +			reg = disp_cc_sm8750_resets[elden_bcrs[i]].reg;
> +			regmap_write(regmap, reg, 0x1);
> +		}
> +		/* Hold for one full ~30 Hz frame before releasing. */
> +		msleep(50);
> +		for (i = ARRAY_SIZE(elden_bcrs) - 1; i >= 0; i--) {
> +			reg = disp_cc_sm8750_resets[elden_bcrs[i]].reg;
> +			regmap_write(regmap, reg, 0x0);
> +		}
> +	}
> +
These resets if required should be taken care or triggered from the
Display SW driver. It is not on to the clock driver to drive these
resets. If these are done the complete dispcc would be reset and when
the PLLs gets reconfigured there should be a flicker observed on the
display.

-- 
Thanks,
Taniya Das

