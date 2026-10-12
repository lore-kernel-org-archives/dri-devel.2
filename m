Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5570CCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A54E610E4EC;
	Mon, 12 Oct 2026 07:01:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2858610E4EC
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:01:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55xRi4068824
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Efnu9rK1FagTbizfEvVPZFQB44bsbmV5V1j12zHm+T8=; b=YY2iaJYRkj4ca8fx
 8bZ6jZvcvd0ssbY/ugQTGnY6/UfhK/9Z7J487hLYz740D7DnS5M7xBzC3fLOFbfh
 9a266wndxtPqoBqEcME7WRu8N+gUqT5WUi9rSi4DhZkn69IDapU1z8EBmlA9LNkC
 DKGLdGz2f3XynnBVkgCAorA0/nqXceY73GgfNnA1Ma8TesCFDSIrI68qNg8q1qVD
 iCYcEGXYVoZ6x+adnkT2N6XEHaCsdFXEcLTSPdtxO+RjTJ6UVcKC27KC9RbKuXvS
 02p9gkiWbafP/mw6qwx5yPM4ouc+lM5S9Ald7WqvuAa4w3kAKr2HJ35hsU1T3vt1
 zeonow==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjn8cc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:01:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93edac58b24so4118485a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 00:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791788465; x=1792393265;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Efnu9rK1FagTbizfEvVPZFQB44bsbmV5V1j12zHm+T8=;
 b=Zd//N8YKMCLVCyTblp6ILuj08cwoSqr827/kxttrRLbUO2CtNW/XgcosmhEyi04wSy
 cXLHQlmuYAGtF9tN5o9uLehZUkGrnM6VUWgm3n0cXZ42EwHqDsPbvjRhbBV4PdD73XVm
 R1gdUMkn799jxrgERY/Oat78P0L778p2gZz1eboHkwYeVLHR3inq69yDlZiGTS8fq4IN
 FdAKZWYYOmOSAdzpL/V9eHi/0QXnJOSQWABW5zojTrtlGLdXqLMseKflGbi8zrS2LfVP
 EK0shQFlFXxTsIyYmrYJX+Iso8/iJfNi+bdGRt8NwamxiLaIQdkrechnwg/jZOFMfxcs
 JK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791788465; x=1792393265;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Efnu9rK1FagTbizfEvVPZFQB44bsbmV5V1j12zHm+T8=;
 b=zIaEC+EGSHDhyBivlzylva6VOZtZNbalik0u0fg66avZ90dq27HVoCaaN5v5SrdFgp
 mzndhuXlA8oANZwFN6hoca5+pmja8NL4BQS9flcK93Ycg9kFZPYOa8rxE+NG6pDSeB1/
 bNUtzYH/iLRP8RO6N2XaKAnyE7CQBAFifkgQPK20ZgUpreYnEnZdXTUrV4A6o9PVNqo0
 2CbGINheDPUBCl1W90luQxgVTmBfJATPovPMAFRQ1DFFYm2QjUH0f7Rh4lg/ajs7n3b9
 IFa+gtSxGLdyq8RPOwfgq/6ATbBpW3RLG9Q8AM38RybF6ICWcN9vnzOs5f7r7c91M81I
 Lywg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwK4zxjUgnPWS0Akoge4CGBe9nL9Tt5l6vCAFCJpgm0cdbykKKmhyAk70XwVs2TKSOTznUNPemJ360=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJkPfWObNH0bQWwLPcSxcW6kVvwGHp4dGByyLLwo4bDBKY4ScnF
 Emd+XsmyPxxk8jmKeN5SreBm9MQStQvRSpj2GWFupf/kUz4GrlABb6hOasnodC5CyS1hqHQ9knq
 E/NScsJt190hXFyyILWoAEyD9ZJpX15BsUmZy1VpXU1gjL8R4j6TG4HmKxmIU+pixJOhwUmU=
X-Gm-Gg: AYBFou3fJXguFI5K1OrF4nQ76xs83T/NlXz4myPljxmxgqUto0pb5Fuh8378Le0QKFu
 jlwFtIhfXTPkg/wZaToWs7tUXeKMkA80PtOkM2NPu/H2Qm4dxVankVnYGbAjGsfhhY+rcjXJ0og
 1LU05EEMn5i2tDY5W8Cjcv6Z1Nvb/2xGNy4M9zxmm7ugqIteDC0VU+G5o+nXd54kIOq/ILy/uZ3
 dw7k4H6MHgJKYPslfL255duzCiPJbhCLKzieJcM8BjHbZ/osB4pzuDVPl0r8az3R6cPqkqpzigU
 plfGD0I0R+jnWROwHjri+dmvoNrMJWrzTTjWdcpwD1ljtLH+yh/O3jRAwo4ZdJe66URmEknYzWT
 AUrrAZbbmQWnugD/gFhKB6w==
X-Received: by 2002:a05:620a:8084:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-93ebd1eabeamr1637430185a.3.1791788464537; 
 Mon, 12 Oct 2026 00:01:04 -0700 (PDT)
X-Received: by 2002:a05:620a:8084:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-93ebd1eabeamr1637426285a.3.1791788464004; 
 Mon, 12 Oct 2026 00:01:04 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9aa94d4sm424903966b.62.2026.10.12.00.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 00:01:02 -0700 (PDT)
Message-ID: <6e67b0b2-8bae-4568-a276-56f9db360b80@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 09:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] drm/msm: correct DSC RGB and command-mode vblank
 handling
To: Zhang Jiaxi <Z1529105815@outlook.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SY5PR01MB1060041363FC41A7F40DF59DBA1932@SY5PR01MB10600.ausprd01.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <SY5PR01MB1060041363FC41A7F40DF59DBA1932@SY5PR01MB10600.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyNyBTYWx0ZWRfX/cc9MZmuUPIg
 qCyiBY6v/xg9J1IQZSpTGkqjOdYoJ0JNTTVu8JRAHr7BJ4DFtKpZ+ZeOGGqbQwU6PD8ch/TyDct
 tGlz5ayd8fYIIrEPcQeczE3AuvZoTd2y6ZFtSpMd0JG2hQOXNtjQfp7sfb1jFM1BX948goDIUfe
 ckKsCVvebdpYfdqYGCpSH5NSGCcDiB88Gux1/4jJ88agDhmoLajk20IIs2W0r7Q/HvCSDqsPK/B
 NiVBqwVEcQH7myRoFoR2/9+DjaapF3ME8NucW9bownlMGcjhntCh5z+LXT7KfXTubwwt27FR465
 r2ojAivPN8mWK/J77cUEpBC1aHoDLuKo4PcwJbdF9jxwYxuuSpq/yIlQ58YTXWmQt8TV/3XS6rX
 3f30cLF5echuwlafOX+mo1cqMkn6aIKsVgBLXFi2HeoGYUhn3Gcut7nkiLM3XORFiHoI4G/z/PJ
 k6eq43fIZoPpyDNiEtQ==
X-Proofpoint-ORIG-GUID: Ip5IgkGGRZrJB0zC9jH2mfUnXsRhMtMJ
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acc85b2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=cNoKYFeJyS4W4/1HdvzxLidmn8o=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=Ot09LXujVt6j2_2-7twA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Ip5IgkGGRZrJB0zC9jH2mfUnXsRhMtMJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyNyBTYWx0ZWRfX/H1dJAiGMvxa
 RpyfuVDzZvVkaKuMI6Jjvd4qgTowRCk/npkOB9DUqlP0HbW3UnQj+6cSG5qXb9R38ZU1AG31AMo
 yT891Uu+ozMOcoo5xh9zuxfB1Y4bKls=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120027
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

On 10/9/26 12:34 AM, Zhang Jiaxi wrote:
> These three independent corrections preserve current target APIs:
> select the existing RGB DSC 1.2 RC table only for version 1.2 and reject
> native subsampling in a forced-RGB path; retain the commit's vblank reference
> until completion delivers its page-flip event; and reject video-porch
> scanout-position conversion for a command-mode tear-check counter.
> 
> Command mode initializes that counter at vdisplay, puts RD_PTR at
> vdisplay+1 and can wrap at twice vtotal. This is not the video raster used
> by the shared timestamp conversion. Returning false only marks that
> accurate scanout-derived timestamp unavailable; TE IRQ/counting and the
> current off-delay policy remain in place. No always-on IRQ policy is added.
> The completion callback consumes the current count/time and does not wait
> for another TE interrupt.

[...]

You sent a number of patches with broken threading, please switch to
using the b4 tool - https://b4.docs.kernel.org/en/latest/

Konrad
