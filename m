Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956C606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mkfPaT17;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rk+LHVpp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F1610E168;
	Fri, 30 Oct 2026 15:02:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C6D410E168
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:02:33 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER6ut346857
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xAOoyxUkYkr+YZ33GmWcIuFlnPb7kgM8/ZT9gYdBOrw=; b=mkfPaT174hQ/k9SE
 HWJlGqvv15Q6tbsQCohC5witKbWUmcpo39kIZHt2bZXyqlq//udZvkU4wXyH/Osz
 yTescl+hZNux0EN3xS4AKsekUC/xo4OyxVt1eAHYoy2I36HOt/Xod0WwTqmgUrWg
 JHetMwzIJa84RMjyb6AgWR+EJKTCcvYZaXGbVSIDG8YtpJT+fT2U/Av+XwxGENwj
 kkgDAFlKXXWRTueIhs6oQwrBBJHxk3Er85d77lJ0/3WRWr6/e6WMtnkvjhQ/kNYi
 c7u3cB6xSUqsjGpT3qw/YZLg10VdousGAgzGn3CeTkkmM4r+HPVaWLQcSZ3bI4Q9
 GamHEg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rkqtv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:02:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2bdebfc5so21355685a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372551; x=1793977351;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xAOoyxUkYkr+YZ33GmWcIuFlnPb7kgM8/ZT9gYdBOrw=;
 b=Rk+LHVpprAaFuF0hG/xJ4+Fzz1jpdphNEa/97rVnkhByWlaq0rUJbZUYQnk9nifzzj
 kpqynRWkuQ4uGbbTuBdtP16sammorEh9i4RXhLivlNVZ+nl3/Dj0z8eCc4qudWTqsmuY
 FeUhH07S3aZAgXYNf350bYAuUSsTgdWEUs6eynMX/jOU8DdZoElrmZH7e/4fbrTtf8A7
 cVnUiqhiHztsTLly8jZuQxEvdBge4oP0sVLaV0jhIbuzwlKbFa1cgeqcQZ2ienddDS/3
 wuEWI1h7vHiqB2CI8OQR4YIcvjK2cQuGH8j4RvbKKHj9uDZTheqWCy7o2WJ0peYjK8IE
 KJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372551; x=1793977351;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xAOoyxUkYkr+YZ33GmWcIuFlnPb7kgM8/ZT9gYdBOrw=;
 b=2tylw8z6I2IcDz34LeqGCC/3bFu3Te+jgCIQ5+uPxxVrq/26tyvhI9ckOsOmGwzDUn
 pqIC2DC0+B4D/PjzK4bcGIRCopm2iDWAxTvvXoMxmbuG9eOrwdjyDABj3NyLYu9yWgeN
 C2CC9D1lrPTFehQl4Z0UmmXbruuUuhpjZRP+aZ+veg1Vi/NyABCpMIM7ZCdk1PU70nMg
 T79hRoQCCYr8mn3R+DTx2fxxOPKBqZpg7nHf6v458TEDEwclynpuvf1VN2lRZ9UVmpLV
 qDopqyov7u65YWVvu59QefYgy6WWmuFFdUzObe5FzO0hnafx3gH6ewxS1NCrju/z4/kI
 NKPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGvsTo+2T1rT5I6imv6uSrFguq/k37sB8qoGwG2Ws3S5L+j8h2voRPpZZhszLo5MsAQYvBLByJVvw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLNB46le7mA4N64mgfB773cdv1vN79Bo+BRYkG3+6MNxWYgK2LM
 LwdbRtq2GjFh33W+FZQJWdV6SaAMOY7MzG9bA3N38KW7CwMBlXZTGv7aSVl9SKmRf6+zJZQWX3N
 ZYj2geElwAWDp24THuMS+fo7s0jI96vxGQVbyvsI+oNZ4P0fH/mQjr5eZk1z4MWtFBy46hQc=
X-Gm-Gg: AYBFou0njhTKQUZaAwTXfIhkRKKvBTttdyb0O6RjT73ps5OA1YIjvnUoy7zf0A91JEL
 XT6bkWw91g7gGGBvlrS5OYPZrTUA8oqmjdksNQmNQDxXyvAHiuf0LhrX42tO80vfdsVpoFKDABq
 erebE68qIUlMV2B/Auqkh4mB00Om0bPkh1d/mPHEAnE8cozG9kq/edTwFUO/sBdeuEuMe3gYru4
 LN+d35sBn/jJFlG9rUOvHQ8/+bm86vC3UKJbZRkkdRqqgEhsnbSjFhTNuVop6/pD/h/UaNYnPtn
 F7g7e+pdW5QktiC3JITUnsz6pchuicJh36o7k6w5AuAxQlQ3X/mhh/PHt2gsvKzq+/jqH6hvsKp
 LcyhQX+KN5pGB0cXzoqLrrTkKQ4j6hxKzeSoMZqeP9nYC7X/aoRG82DQ27J+T/BUVBWctXTQ0
X-Received: by 2002:a05:620a:72cf:10b0:93e:e111:2771 with SMTP id
 af79cd13be357-94421619197mr420076485a.2.1793372551190; 
 Fri, 30 Oct 2026 08:02:31 -0700 (PDT)
X-Received: by 2002:a05:620a:72cf:10b0:93e:e111:2771 with SMTP id
 af79cd13be357-94421619197mr420071085a.2.1793372550552; 
 Fri, 30 Oct 2026 08:02:30 -0700 (PDT)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4eca214fdsm37486a12.36.2026.10.30.08.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 08:02:28 -0700 (PDT)
Message-ID: <d265dd66-d8fb-4fd2-b6cb-d50462e4b6e2@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 16:02:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: display: msm: mdss-common: describe
 additional block resets
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Taniya Das <taniya.das@oss.qualcomm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261029123238.29877-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261029123238.29877-2-xiaqinghuan@mail.ustc.edu.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029123238.29877-2-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UkBGIlr-UOrTNY0QMc8GSGeyJih_YXCp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX9bIU18vjbrca
 tX7z9SWqH9eB/62ctEXVIqVxZTvlZIchZ0BXp4X2iMcBtzxK48rE6qlMwQbsf8ig8Q5m96oBZLT
 XXWhD09UDXfgH8Xp9CZhsVw66LWiGzw=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae4b188 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=dBPrbYW5IX62wmfSqDEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX/ZU9e8UN46Gi
 w9dfMN5xk3x0JynuoUHbKTizmN2TJkzzC2x8pGRmN/klseClk6HOBmbZXpCrZFSvmyX8U15MBiQ
 ZI86pKOy9DFNKy9R28yV86jIz9bSxwi3hN9aomPeHY9nfBMAHEeVZ1zeNacc+77bo85ora+HVm0
 ASi9rp30CLJzp01ApgyIpn/ZR20O1ksRypVxiH0QmygZSQ4wnxLgmYmIEw5eKusd70Mmye/oXvu
 KnXMiL5+tMTMohk7vFFc/0NhHbmgaqdT5Nt0SZbEQEDL6Kbk/RcQk1CmP4xLVxKtWROJ+W/06IR
 pEBC2AT94gAKr+butorR6+CDSiDnxS7GJjomDYhK4Q4jwPEzf7gkjaZeKwASTJgztelJEV+jPOC
 kV4l5y5UVXCx0EYazUuK/xj1041A5qvETizGS5Wqo0bb8zeZdT/a8VQyKu41y07/Km4vid3KseE
 tidDrgSZBQpypR6K3Pw==
X-Proofpoint-GUID: UkBGIlr-UOrTNY0QMc8GSGeyJih_YXCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300059
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 1:32 PM, Qianhui Xu wrote:
> Some platforms provide more than one reset for the MDSS hardware block:
> beside the MDSS core reset, the SM8750 display clock controller also
> exposes block resets for the MDSS core INT2 interrupt controller and
> for the MDSS RSC (resource state controller).
> 
> Allow the resets property to list up to three resets, keeping the MDSS
> core reset as the first entry so that existing device trees describing
> a single reset remain valid.
> 
> Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
> ---
>  .../devicetree/bindings/display/msm/mdss-common.yaml         | 5 ++++-
>  .../devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml    | 4 +++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> index c6305a6e03..7c0ac90511 100644
> --- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> @@ -84,8 +84,11 @@ properties:
>            - const: cpu-cfg
>  
>    resets:
> +    minItems: 1
>      items:
> -      - description: MDSS_CORE reset
> +      - description: MDSS core reset
> +      - description: MDSS core INT2 interrupt controller reset
> +      - description: MDSS RSC (resource state controller) reset

MDSS RSC is not part of MDSS itself

Konrad
