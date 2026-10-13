Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E50CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FEA610EFC4;
	Tue, 13 Oct 2026 18:51:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620CF10EA72
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:50:46 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DHuw3K1125314
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CU7IDZhSwsFbiiRw6REpkR9M9TsmBZVPn1ZvgDZyk8k=; b=J5OK1XFlmtVmGlYw
 bXhJFQIYOyGR2zofcF9riYiqLzsJ09HW8KiVhETCaKTa0jjMtdnoiSAr67A0SHXU
 +5VZmFV6EP7XnlP31tCLwRGqOS51wdSSaFkzL6g88y9noDVC8YWi97+VSfuULMGz
 3aaNyRmGc2L8vc/fs4gPVqgjUZPeyl91N1hDIhSueOtJBPRfHvnD6OK2zPbympIn
 6Fs4XRXj1luUoL6MH4jaQnCpIawwfixPWQzOPruGvnvwl26TjLDKKUQoFsvX8I88
 SAgDIxxrYmpsy7SGI0ZH1rbzqdIvXa0ivyKxhVkIFvearp/n7bLzulitaTv5icu/
 IsRbYA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sg8094y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:50:45 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so2883852c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791917445; x=1792522245;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CU7IDZhSwsFbiiRw6REpkR9M9TsmBZVPn1ZvgDZyk8k=;
 b=VZY+Ksb9SPGNe3fzPsN95cS7v5fiwWMwDwi5EGXnNtPoAQc6C+xACZSbh1xIo0Lhzn
 AZzwqXewfZS/JHm83/XbrK0jQpA7lmhqsH6GwLTabA935t3HgKdeZgj88bWGTcKArjWW
 3a8RC57So53ZlbvhoxUCI+wNN5YKWOnGgREUkHTUyMqtrv9nAcAp4A3ImjAEW7ZAGCyN
 a9dev7bpYJe/5NUGifSRXuEJEraRs5SBSUL6/ubIgGTx//fvl0U6rMh0NBnIL0zbOpEu
 qV47bP/ZRujAXGAQrUvqVtX4ikWohPHVXvR3FtD14RedgAq+i62F0k07wWZ5+XFb56i1
 +tNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791917445; x=1792522245;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CU7IDZhSwsFbiiRw6REpkR9M9TsmBZVPn1ZvgDZyk8k=;
 b=BjvSWcZvcJ1XGG2wkZOkIPLZqndE8NF9l/GZgbmga8eQXepAvzEHsSm+M95ExG5eG3
 NLmh+NIhd34IqYSggpFF/uy0jBRgTchFEouYLY2zt/lZU1ZWFxGkRJrrY8MdrYm+wj0O
 l/kKg2ayI4s/E9cM1okX/+3MGB2z2+mjVJBo4dpQ09E4UBN6J/vf5QvnjegQDXQJQnMC
 tqcXcBfQqf1ga6R8kzIIUhnbfuNtOPMg91W8D7cQwQYeGvSFDlhLfoZKQ/zYcWW6oXSi
 xWv3505GIV5zSvm3c6dKkw8/Kfe9JmpmFVlOWE9JM0fUuu7c7I4FIpAXPQq9vO2BvH9V
 n1+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1zHvmjYwUp+JLYxjc8PFdTdlXajYjfbJ7UQ2KJSPbcJ3QxC2G1BNhgMuPvF0QV2oA0sy6VLzkzww=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI2YH+nsE5Ikb9C6QFagWdquiYJAPaJXQCd7715Ri9jhYWutLAg
 akvy6ADFEHlp0M5GwYs5I0Z6x1eVjznETf6CsvuUO0woOVIhjZ/VqtkRrL9DD5nJPiX7onZWvkJ
 A9ATotRRf9iHS7CYElKAKsrQjYB9PKgAKyOkSrMAOxlVGAidbtkdONX58caKbdl5aEhH4aws=
X-Gm-Gg: AYBFou3XoNlM3T59YQL86sA1ZLfGebeVzyZ2SUi0EYTvlT7shgvhJtCzlQliSaemxnn
 fxJXftJnRGzuc5grCfD0VMt7UYeVJG4JI1sPWLzAJVl/DGwua2tVausl4JSqix6PQnrNZJV2P9g
 k/89NmbK/n5sifB95qUELNmyZjBV46f/GcQmEyI/3++BhrPysjZG+xj5xnG2AFNl5tAHphvZ0E/
 QtanD2ZBAZ7CCTsLinxyd0CJdk+1LFDOChIipjqNDAYrZFgJcO+vZmm5Txh4jKayKcpPJYoi/UT
 ynxH1Ugy2Je4HP6prckgBfwU0NP6i//JnW68zOSYgG+syu8+uUexEngSjgXCCMI7bC4NA/8lSNq
 Rj0aA3lGrFawTmWXvZGS3DscXAAfhXQ22wmdf9lKvzEDmE2HhhA==
X-Received: by 2002:a05:701b:205b:10b0:148:722b:7cbc with SMTP id
 a92af1059eb24-16a5dbfe430mr18480531c88.14.1791917444693; 
 Tue, 13 Oct 2026 11:50:44 -0700 (PDT)
X-Received: by 2002:a05:701b:205b:10b0:148:722b:7cbc with SMTP id
 a92af1059eb24-16a5dbfe430mr18480483c88.14.1791917443835; 
 Tue, 13 Oct 2026 11:50:43 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1746482c978sm20027730c88.13.2026.10.13.11.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 11:50:41 -0700 (PDT)
Message-ID: <15ec8059-b73b-4c28-a326-ca9a8ef7cec6@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:50:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/qaic: Add support for AI200 virtual functions
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Sashiko <sashiko-bot@kernel.org>, Troy Hanson <thanson@qti.qualcomm.com>
References: <20260831135008.1418190-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260831135008.1418190-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8ZsrO7XQllyXizEFmvQB2nh8QyKBIBY1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NSBTYWx0ZWRfX6Us1B5lXdXRY
 SBeG0dzbR+eVChp7G2PvfRiAqwecqBmbnG1lcRVVYSUeVbNvoUoi9oJ/0o8L9Y6dURNXKKlca12
 NjOELdhPYmYJ7K8r60ACle9qeQcvkH4=
X-Proofpoint-ORIG-GUID: 8ZsrO7XQllyXizEFmvQB2nh8QyKBIBY1
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6ace7d85 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PocSdXh09T82xRbmK9gA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NSBTYWx0ZWRfXxgIQ6MaYAKkr
 UC0c91BW3XyoZ+4nqlhkTCvYN2Gfntbu45W5qJwM0NabJBGscog6/DICYl3Mctz1NCSkFLrNrga
 xxm3c5NY0NFIqhbPxiAnXNy6R3OYFjAfSco0QVhsMjIkl6SQw5qv/12haRtnsYd3ut1jQ45SsS2
 JI+2Q3WgaEYVHX321qPZV3ZjHSM3C/Br7pF7abkjMlV3hTHmwWnpr6XHywTTTWb85iczecI+l9i
 H0fLu1gCXNiu20Zi+ouiMak5x348FBN9vtBQ9TVshKru1oDjLHbMt7SLqK8qfFhk8nQVIjU8xRp
 COyRE1Ao77gbnQvrfogODZ8NM/HrCV1AkQErOfDyZl3nYBJoKJg3jvGVUfDxFgjoWfv8TrwPII6
 d701Ht7NWEaK2TcxT8B2SeXGNW21eWkzAH3/W9mZnXHnriT3ygTTMCvNX50mFk8oJ07Nf426ptI
 d4XT5IcbOm2eDw+Z7mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130075
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 8/31/2026 7:50 AM, Youssef Samir wrote:
> From: Zack McKevitt <zmckevit@qti.qualcomm.com>
> 
> Register the qaic_pci_sriov_configure() callback to allow VFs to be
> created through AIC200's sysfs numvfs entry. Additionally, define
> a new MHI family for the 5 channels supported by AIC200 VFs: NNC,
> Telemetry, IPCR, Loopback and SSR.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260814165907.C76841F00A3A@smtp.kernel.org/
> Co-developed-by: Troy Hanson <thanson@qti.qualcomm.com>
> Signed-off-by: Troy Hanson <thanson@qti.qualcomm.com>
> Signed-off-by: Zack McKevitt <zmckevit@qti.qualcomm.com>
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

Applied to drm-misc-next

-Jeff
