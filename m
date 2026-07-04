Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2ABC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 00:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020B410F9C1;
	Sat,  4 Jul 2026 00:12:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AB7OWI47";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CjVPa21n";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6510110F9C1
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 00:12:24 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KPblh1020417
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Jul 2026 00:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KaDSi7e3TmfTh0GZrV+FHaGBZpt/a4TRf+NVfY2hKpE=; b=AB7OWI47uZJ6uL3v
 ztr+GMKil8gTL8sISkVZA8D0tYY0Qc4gGEG5wLIvaEWDLVEVaTENmt9aArh/B38O
 TDFZvCf6ITLYImHQ5Gtwn89+swbO4Y9lE4aShIfE3+NZa9ARH6rElQk9snUytWTa
 mOzJ/gaQMywU2cl4Zf4UZcNQaTM5ec9HzS8KRK1l/QBiYVF6sLZ1UPBnINzfOfgH
 RNeb1KbXSuKQ3dhFyaKmfE6AkO36x5Lbl5vXAGc5BX4Ye64jk7WOin8g+f6KM0/M
 6997EfIPilvBFYK6huCZr+BgW8TwApoXvzfiItQnWcLH3sPf6Z1gQAsOIad8ulqU
 bzbtag==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkhugn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 00:12:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e7ee64b25so175455585a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 17:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783123940; x=1783728740;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KaDSi7e3TmfTh0GZrV+FHaGBZpt/a4TRf+NVfY2hKpE=;
 b=CjVPa21nCPmUilb9IGUc4okMF2Z1D+tPgg8VEfxIWbvORkS9493DXNbNSRNSGNIXYA
 HkCZA4de1bsIyqsxC+7VStUlt2nD3HrYVm0LMobnrsBS951t1BIfdLNZu8hS39Qf3oiy
 20d0FVpcrEWZEKMudZUQJlUSU1GXOMynjF/LRKe6c9+NIpRPSvLmia9yAlthEiD4pH5g
 2+2YT19aeL5jcYYBvt0R1LaQ+tTqtSSa/jr3XH0CR52noG1z1cyKTEgs0Zw/9bVvUMff
 iIroEA5qHUylb5k+iS0dNfcSSv8qo8gBS+uvW03lxedy4LNJB+OvSCGXILjSWhZkOqM0
 te/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783123940; x=1783728740;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KaDSi7e3TmfTh0GZrV+FHaGBZpt/a4TRf+NVfY2hKpE=;
 b=kJMclnePSgPGRSxeGWtbf0btE0eDSgRUaTy7wLuq61jSCvzJZwVvuo2byHu8eRcfvt
 qoHqY+QhWJHlG5clHyM11LPLaFyW7QKFZ+vc8TcmvTjaEMV8gk4DeyRtbz0l6pEoLi6T
 QJ9sZ4qp67f4aEhsy1NCWuvv2jDsYBZFnBaKVd3xkpleT/37Xnz2l0ZSmxRdc2J/lcwC
 fn7Dxk/Xs59q1pbtuDOb9UG1BOeuXdfhLpsgPzkWyzaw7ksz6rgFzpwrBujrm2LNMtNr
 Gcsskk0ZTSeTV6W5MJoqfEm4Xuwu/VwfAKxQiaI76DidSWznNihTHEULsCeQTpCskmMW
 QIqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+ruERD2UCKk5FDaoG0qs+Q+Af+x2L0BUZrDY2dVNMHVxrX2Q6SveNA6DS0CjUWf+wpb1EeIkqc8o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUuHXudJmXxPo0mut2EcglWoBUZZVO8kduRlaiOqk6nZNAO7WN
 1e6CpVd94/2I6oiT3hcxAOKeL3sHWERowTHpkxXAQJ8c3/afw82CdGnw525qfq1u0X0pxGLF0Q7
 2lnmoYxRQH+1yjRLjGaFnOrSXC46TmTbRhUINSOZlZv5AIWyKpOfMJJjVlLX9MiA0+nmBAeQ=
X-Gm-Gg: AfdE7cn0sm+Vdgip+A8FNlIQOs8i6oS24fXgfhnui7GVseXxfEuYWE/Jzoo7+8RzC+J
 qQsW6R6gfuEfv/zI0nt9eAEKrH6TnsqINvs22jH/gX7nB8gvqTB9miYcuiE6qsntJh3CzybEZKZ
 /XDrgJiQC9aGa5+Fj1m0fx6EwqsOJm9F8PSAZEV2Xzl4NAZyJ1w5BwtkXkUcMCe1dkqUrT7yMzV
 INtS0uaR54psSIenDKjShmJjoABjIqNsfpzAw2/Cj2CFZEWx3oiSuZGHdNievItp1/zQKcXHwP5
 BaENaIShVXKJMQuHF7Hydjh1zzi72pzVu/dF2lomjLIXZT2NvefKa2xGspX5JrByxA7XPZhnlUG
 /UlzQw6vZ5Xw/Au5qNLAz+6+mDFZd0ClZPdZa3hDrcGtUkYjVuSYa+AL+vW5rwHJVcBiPkttv+X
 i0VoqFHQNyR6IO4XH5JGWeQ4HW
X-Received: by 2002:a05:620a:4114:b0:92e:7ef3:213f with SMTP id
 af79cd13be357-92e9a3502bamr221691485a.23.1783123939684; 
 Fri, 03 Jul 2026 17:12:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4114:b0:92e:7ef3:213f with SMTP id
 af79cd13be357-92e9a3502bamr221687285a.23.1783123939120; 
 Fri, 03 Jul 2026 17:12:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13bfd12sm845506e87.57.2026.07.03.17.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 17:12:16 -0700 (PDT)
Date: Sat, 4 Jul 2026 03:12:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, amahesh@qti.qualcomm.com,
 arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Subject: Re: [PATCH] fastrpc: Reduce log level for DSP info and reserved
 memory messages
Message-ID: <q6rh5lnqmulzuio3hu3773d4cfyhkoblsba2bcankfcvb2vcwq@f4clwajq5qdy>
References: <20260514062825.50172-1-jianping.li@oss.qualcomm.com>
 <cg526ebtmnboqpw5aabwrtmoc7fhnvc57dmjax5zltcjonnazv@pynuwgpx3bi5>
 <d883112c-5ea5-46e3-abb7-f7c611f52ab2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d883112c-5ea5-46e3-abb7-f7c611f52ab2@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDI0NCBTYWx0ZWRfXxcMTy+uvf2Et
 RmdtL2Cz1CnbFqZUi01EfWbBlK4wG6bjvyYVrV/gJqZ+C9E4WRPdp2w5DNLJb4v7aLiD9e2lmIl
 PDotLUN+Dw+sDeMj3KMBDBbDJeN4uuSLQpcJGx3iwNIssB0aKtDE+P76YjzCdNGuGtsc95IjF85
 OSAkbO0CUF7h4zcZiIJYBZ0IvZPrnSPisC1mDLUdnjBnPjhL61GgyRdTP14/OyEJ8YNkx3poFCc
 FyAeT3RMZX7PBywSyCmm3K5gpnwku4xnmHIcXWTaQjDkOSSru80zjabEtJJsXvwmMr1Yjqt1T0Y
 7RwQMatIDQQqWQyRHuyDb4VCTtZinwkTj4GEy/dfmtno9OOZ4H7SdfFIMr2PDh3VmBoHTLO6Vq6
 OkizIAAK7k0w4ezNBl+wUTXiENFH/auzOf3Nf50JWsDi3FgqC+uTZeaDDTxS/wTuk4KB0Wh+bfH
 esLi9tK7kPHI7naztgw==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a484fe4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=HobEkzpNabFFunooC3UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: ny7YT47_UPtY7OOHzBOBQonRznsBbly3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDI0NCBTYWx0ZWRfX5OmmhhbVvquw
 pqVxZeR/7Ymhc8MFiKyPRaMoQOc9WPWspm5boU16ARB31KckN44DDl/a6FKfdDxYnS6nyaskp9V
 bKcdJo7bA+HzdoyQaBVIo7JWSE9Xkfw=
X-Proofpoint-GUID: ny7YT47_UPtY7OOHzBOBQonRznsBbly3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030244
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

On Fri, Jul 03, 2026 at 04:31:43PM +0800, Jianping Li wrote:
> 
> On 5/18/2026 7:08 AM, Dmitry Baryshkov wrote:
> > On Thu, May 14, 2026 at 02:28:25PM +0800, Jianping Li wrote:
> > > On some platforms (e.g. QCS615 Talos), fastrpc may temporarily fail
> > > to retrieve DSP attributes during boot, resulting in repeated
> > temporarily? What does it mean? Should there be any sync with the DSP,
> > letting the FastRPC driver know when it's safe to retrieve the
> > information?
> 
> Hi Dmitry,
> 
> Thanks for the review — "temporarily" was a poor word choice on
> my part, sorry for the confusion. There is no boot-time race
> that eventually resolves; let me walk through the code to make
> the actual scenario clearer.
> 
> The FastRPC misc device is only registered after the rpmsg
> channel to the DSP is up (fastrpc_rpmsg_probe ->
> fastrpc_device_register), so the transport-level sync between
> the driver and the DSP is already in place before userspace can
> issue any ioctl. And fastrpc_get_info_from_kernel() already
> caches the result the first time it succeeds:
> 
>     if (cctx->valid_attributes) {
>         spin_unlock_irqrestore(&cctx->lock, flags);
>         goto done;
>     }
>     ...
>     err = fastrpc_get_info_from_dsp(...);
>     if (err == DSP_UNSUPPORTED_API) {
>         dev_info(... "DSP capabilities not supported\n");
>         return -EOPNOTSUPP;
>     } else if (err) {
>         dev_err(... "dsp information is incorrect err: %d\n", err);
>         return err;
>     }
>     ...
>     cctx->valid_attributes = true;
> 
> So on platforms where the DSP firmware implements the attribute
> RPC, the message is not printed and the query happens exactly
> once for the lifetime of the channel.
> 
> On this SoC the DSP firmware returns a non-zero error that is not
> DSP_UNSUPPORTED_API,

Why? Which error is returned?

> so the else-if (err) branch is taken every
> time: valid_attributes is never set, the next open re-queries
> the DSP, and the same dev_err line is printed again. On RC
> builds with metadata flashing enabled, several such clients come
> up at boot and the console gets flooded.
> 
> I think lowering the kernel log level is the least invasive fix.
> 
> I'll respin v2 with the commit message reworded to drop
> "temporarily" and describe the above accurately. No functional
> change beyond the log-level downgrade.
> 

-- 
With best wishes
Dmitry
