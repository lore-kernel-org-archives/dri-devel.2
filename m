Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C1606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QPqwhfwr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ddWDZxfh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 514E610E189;
	Mon, 23 Nov 2026 20:02:17 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E0810E189
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 20:02:05 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJutMx2862781
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 20:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 inPEp8eoSPmBllPRXHFJA9PQnGIe5ryUBe6DPKTKW+M=; b=QPqwhfwridzPvWFn
 bviNXu/PwlCRHBc/tWm3075w4rEGFNhMmAPl2McYHbhw6yzIB0iFR7MHLyt8zjoJ
 R/55xnAPrMHD79kKdoUJyazct8XjicyYmMaHExINHsc281h2ACuikJ6BAQvLxknh
 FN6HwoC9l3H4M2zvmmctYBs8AVKyNDV77gD3y/3ZVv1U//owdhy/pO0AZ27vheMu
 yU5QX2h/uE+TN76IF/DMR3nGx3VFWkdSxTYK8JGiidXybeWZGk9XSR67rum33vAu
 47XbKY+R55DRDvAZoes1hDRAan06DqSWSh4vHGcUI2F2EDdLjbmHZpvXpzC7k7yc
 hcqNlg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4m7ut75j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 20:02:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-375bac6bd21so4117738eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795464123; x=1796068923;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=inPEp8eoSPmBllPRXHFJA9PQnGIe5ryUBe6DPKTKW+M=;
 b=ddWDZxfhIWP7vTUiPLUj6Siae9X7ygffJ8fHJbjCj9b0hAFcvHEcf0oEbM+OjcPJs3
 mbEd9xdMXWbnu5kgVNKr5JSL4l2uwFXTJm9nC2MsJub9bUIBEnMREIqvaLkHLqiqSpJ0
 dvwGmKTBhK9tSyROu5AFRteN0AYXzePft76GgbsZI11vDRW98RFuU1pk9+cb7zrCDuyd
 TcqJHaOU2icUS7yEbSC4MZnpl9aXbUL1ZBxKBfF7ONrnJ4SC/3FwDc7iPSU1ff0WHHCw
 g/xq678JENyhhu0QYkY1+6XWCh1AS1D5Q+Z9ThChV/MIczwdxs+2I5ix3YgnIYaWYwCE
 k8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795464123; x=1796068923;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=inPEp8eoSPmBllPRXHFJA9PQnGIe5ryUBe6DPKTKW+M=;
 b=CwKzwddUbkuahquCURpvvPynyL4DRNhPzJYbNexd6x6Nc15yUE0exNUg2SVc2iWj02
 k0snd7eXiIO5t9V7lTAqex9ld1Da282EF03oK08qiCM0ooCCk+ifVKbCJISUCYatv4e/
 wu0BabUIAETRvTLJTTS5AbhwqIvE2xkd1C0UwbAy6Y0+98HwzmpLdd/DYmHQ2hBRfDRe
 lGvg1vDTZ429GwU8rCr/deB9kNEgAFIdjTDj+eCPzKHf/7Rqq81jDSO12JEkkocyT7GR
 wnUW4Z6cQg08dX5QQh5KurtdB5uIlYSz6clbFc0/pKW3rV8qo01vRWD6Z9C1GWCsEjXJ
 oAew==
X-Forwarded-Encrypted: i=1;
 AL+hErH1xLSpbbprd8wAJi0B/hq8J6yqktaHWcXhroZZ7T2NWZVwnwWVgt6wdbN8KNziTIdcvgp5uP7nTDI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+gPLI7ctjk8On6wiNeqL76jz9JwzPzEO9lC6k6S64NTH+TvpIl
 sq3csDibL020sg1Dq7h4bzrNRNdLB1ZajetJUHZbYB1pV/XLgZc8mn2zTdWgtkgKk76vd0ly6aT
 x5b2WT2/W/Ot8twebwKWkeAlop9uy5iWjc058clzRj05SAsPFo9nbAQ8T5QlCwBBC+zBjduc=
X-Gm-Gg: AZFdTZcsQgv7TJpIJN52HOtT4RAJh59u9s1t+5F3UJ/sAYstl9iZa7MwVGC5QMLyb53
 jWYPiUJCd+KfseKhaEZxDyS7+68nuyOXruGiWOEbYqbSIK4MwuwBpIX9S8UfG0puBTByVMEONQZ
 NMtGLBqbH75VmkxVkTQerXSp1WRSeSMISdwcFLVYwu3awZVbPampH3tWZ53rour/LPWZI+JpfiG
 lmeTS8L75uQO9YHDoSysizVLM5AJnNTj3bXIs10Kkp5LjVpYFlrveE0o3EkgWMBRfDZm5LEO/jj
 osiDy0SF7XaBGA5pK8d/TQbuQdUFd6lZgSJWGPAdPYiBaD+LDKoaRc3gACzdw0xnygS3ng0JOcs
 AcB6A0/9YutQtASOdjEu/S5+QO4+zHEmhoxwFkadr5GRhnLKc4sFNsEqfDncFdfYvRuKtX0w=
X-Received: by 2002:a05:7301:b8c:b0:36a:2f6c:490e with SMTP id
 5a478bee46e88-384b3986ef2mr15532181eec.6.1795464123137; 
 Mon, 23 Nov 2026 12:02:03 -0800 (PST)
X-Received: by 2002:a05:7301:b8c:b0:36a:2f6c:490e with SMTP id
 5a478bee46e88-384b3986ef2mr15532139eec.6.1795464122304; 
 Mon, 23 Nov 2026 12:02:02 -0800 (PST)
Received: from [192.168.1.9] ([106.222.230.69])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385646633d0sm66658717eec.3.2026.11.23.12.01.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 12:02:01 -0800 (PST)
Message-ID: <e4ecc291-026d-4ae1-a391-5f3856df8ce1@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 01:31:55 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm/a8xx: Add missing preempt_record_size
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Connor Abbott <cwabbott0@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261123181306.420017-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261123181306.420017-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: K2ncmSMSXFDbAHk9_rh0PG2fAdW9QEx8
X-Authority-Analysis: v=2.4 cv=KurYSmWN c=1 sm=1 tr=0 ts=6b049bbc cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=6/OokicQZQM7IRI9QMJePA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=C2-uWAezvlBjfc1kpfMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: K2ncmSMSXFDbAHk9_rh0PG2fAdW9QEx8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OSBTYWx0ZWRfX8tyM4ut4OSrf
 dsMe6soPw71FGTt0L447dwn3EZAJuBxUXQYYfAVrM3tQxqrZhI9lPjOH+jwttqo7RJD4SdY159J
 g/OUIqaa9oKN2FCPktLaMHrUNujVcB8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OSBTYWx0ZWRfXwzLIrAsyRtDI
 KTEvCoL5MTT6krWhaH4aGnIbim4UYTiw06EXlhCGNz05ggvQWxzZT9HkLHqy/MzIh8Xk/H1hU5X
 w6JwcYle2Ru/KlhcfMr5tfGOAzKxsF1Ro+YbgJHXegBxw1XB03liHT0Un0kDJwhE6ZjH8mOe9Bh
 7bXZe5m+inVJcZQIpta4fjGVaO201qD/eLpwVLSIPTJw81aK7CE1nwc1nQC8P6VJBqcF06y80Jc
 z2ZAnoDXzlF2kfWdtjEM9b88VVOhsEUpRiRgmX9lQSTptp8al53NijNEpXyzYhM0liMdbN44Rr7
 qXeBidmQSwKWsK7oIuXVwpQ6WMwfWT85bWqUOMJVNI+jIclMjoq95ZhiAir2loUpQQMaOlD7Nm0
 Up+Ztatc5zNocEGe7IsmXY7rx9sKccx4Kd1k7EWKht3pxcfDWRDSbAAQpeL5DPxEdr6PJN2W5LS
 92+xTExf19NLQnYU6MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230079
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/23/2026 11:43 PM, Rob Clark wrote:
> Somehow this got overlooked, and Glymur/Mahua were falling back to the
> default 4MB.  Which is way too small for the amount of GMEM on these
> devices, causing faults in cases where preemption needs to save GMEM
> contents.
> 
> Reported-by: Connor Abbott <cwabbott0@gmail.com>
> Fixes: 7fad33097e67 ("drm/msm/a6xx: Enable Preemption on X2-85")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

I think it is a good idea to add a WARN_ONCE when the default size is used.

-Akhil.

> ---
> v2: Fix typo in commit msg
> 
>  drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> index 0c6dde3cbea9..20fe93b83c0b 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> @@ -1337,6 +1337,7 @@ static const struct adreno_info a8xx_gpus[] = {
>  				{ /* sentinel */ },
>  			},
>  		},
> +		.preempt_record_size = 23088 * SZ_1K,
>  		.speedbins = ADRENO_SPEEDBINS(
>  			{ 0,   0 },
>  			{ 388, 1 },
> @@ -1469,6 +1470,7 @@ static const struct adreno_info a8xx_gpus[] = {
>  				{ /* sentinel */ },
>  			},
>  		},
> +		.preempt_record_size = 17712 * SZ_1K,
>  		.speedbins = ADRENO_SPEEDBINS(
>  			{ 0,   0 },
>  			{ 388, 1 },

