Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918A6CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C19F310F303;
	Thu, 25 Jun 2026 14:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A+ZrwLga";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BHMLiGMb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E0CE10F303
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 14:57:19 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9k3aP1755363
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 14:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iKWgD0sBMNUtkFFE4sZvGRi1NDevsu9SawQvBGWT1vs=; b=A+ZrwLga1JQAcf3a
 tXoM7WKfE5gowj1geHsrAklZ8vFrVpD23OHdk+MOvWVDiSvfGZFbsVUOL8wU9iq5
 vrrwpdPIF4y3Jn/dt4+hpCU5EtCW2y4Za96QAbPUhmKIMhc5wKi0LPt+p6vZiNqJ
 Qzn/V7JeiIFIk09rh3seG/rdiJQAuGidfsIP/45n6Z+O9gjT8A+YwKitRoU0LKz5
 xrzQQjueZjQ7W+VdPZl9yvRmUNM/WdBe8d6VZr9uafVufdiMn6XmmMTuUaaJKR0b
 MAFdOloKEA0dDKPtE+TtJQZQPfSdcIAkTwGwR/sLkhI8yImId66fmj1XDw0kfXQX
 0ixsFA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q2d2g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 14:57:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91598ab3a1aso249161585a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782399437; x=1783004237;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iKWgD0sBMNUtkFFE4sZvGRi1NDevsu9SawQvBGWT1vs=;
 b=BHMLiGMbshtiMiqSMa37Dz56DrWCRvwBgtY7ctnOrkXItDNXYdV8kPSy6uR/lz3Nos
 zUetAPvU0AuBW4X0q7AEbn0ZfQCbbDNWqDr8yPB/JmXY+i3NGArqPEVrYikq4MQJd95p
 CbsPz2g885TnXiy4MMLAFXZ5EarlRqdjdxe6IDm4lc/e+rB5ZpS9re6+L7ppAUB1k1Rn
 iPlL7nWAtiijvMZbP0HRUqcAxxMQKz0Pg+TSbBaLAXfFemCD4kj1OnvWP1fkQqREIZpT
 zhXz+M6a2/5fs9CSXaBs5jahxtKGZlPq8DvcuINGOf0xBf1rVAoHlC8CbW/p6jg6Kf85
 WHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782399437; x=1783004237;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iKWgD0sBMNUtkFFE4sZvGRi1NDevsu9SawQvBGWT1vs=;
 b=IYSbxd6CGpsJpiKpTfMC8XF8VA4md5J2nnGZ8Or3AwzYMND0MRoXug/yWNaKbncPyl
 dukP+cf5RlM3dWUrFlhDpXhE57T5osMNiXI/ZYIiCs/HyVYpT08TErlWNGG0Ad3Qg+wz
 Pr24cESfg7lUIjsEAyfCeuCk93sUZd7R8ee1IlFuLLNw0QUvdpATsyaM0gPmhoCAPejT
 VtFqnpOSpNw1L8y3L43XewJ0tNlWt/noRtgZEf46sdNVgBgYeru/e4jkvXZ9pudsRnqJ
 Qd9AS3m9sVYJk1YQ5Ev0IDgFDEB0xtUggrLcp1ya9q5rDkZnaQR4/RPuWYv5iAjxZNKw
 +p1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+R5lfj605BkZXiJNPfTPXwjPdHF+YfyadgUr9TwPBI9bBOq4kDzzY7MujJlfvYrVr4aUxAhFd6QVk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQBlcVdaq0y27Uxi1/Tozk7nQZVzYGyvauzr3e0xqZPcsd/ZIU
 h6wTmNOglLnuE3QwLKi8TsYACvFDXiaG+Ibc5fHXUp1rY0eWlycoHGEyoDS50G6BrdIOEH+sKZS
 Iv1gzix3FNTTgFhU+BNGvXanrJSl7Qq9YyR/CnRU70tU/dAFysXh92NdcOeL3ExHCUrWfZcc=
X-Gm-Gg: AfdE7clVObhDcCrol+gcH7dzLuKnGsFqpmteDudp/cx6yrezKHGsWIHS4tTtvfHMKOZ
 qZXmPBaF8VfTYN8kKn2ga2O7sSr/22h9pr5bNJH3SOWJhNHU0ovxXM2Mg3lkneOM9mtmh+2zqf2
 V7KMtTLolAjiOhVCY7Ylraf49LBCPzHIooib/ekuvZEtsIomymXEg/WGII3UqI6rkXRR1l7Fiaf
 yRK43kWtn33yNEsU1exfRct4K5ZgaIg2s07thuOGEdyRd63dNIw8VBcCyixk4FU4cwo52dfi7iW
 pgXQ5bloa93h35jjFQTGF14EytST9cS59qFupEyVvf3H0bCMR/h+1TqCUwL5Ua4RQFi3+KI6OAn
 +YXJEscrxcP2xlmCMmj9WgVpI/9NFqvC26ykbvp/UP90FgTwf1goHN1ppfmdwQjYEbdO6+5ZFgr
 /6XNY/y32A384LdXpMuGcbbW+B
X-Received: by 2002:a05:620a:1b91:b0:928:a304:b568 with SMTP id
 af79cd13be357-9293abaf9b1mr422683385a.18.1782399436605; 
 Thu, 25 Jun 2026 07:57:16 -0700 (PDT)
X-Received: by 2002:a05:620a:1b91:b0:928:a304:b568 with SMTP id
 af79cd13be357-9293abaf9b1mr422678385a.18.1782399436138; 
 Thu, 25 Jun 2026 07:57:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ae9cb1156asm1775632e87.54.2026.06.25.07.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:57:14 -0700 (PDT)
Date: Thu, 25 Jun 2026 17:57:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sunyun Yang <syyang@lontium.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org,
 Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com,
 rlyu@lontium.com, xbpeng@lontium.com
Subject: Re: [PATCH v6 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <tpqutwzasfwhraxzymorkiot7uryef4l2n32fyo3i3fp337sak@fugghdkcqfrj>
References: <20260508134009.4582-1-syyang@lontium.com>
 <20260508134009.4582-3-syyang@lontium.com>
 <3188f63f-5358-48d7-b934-af20a8f95c6f@kernel.org>
 <CAFQXuNbKBfyeQL3N3P5QY=6BWoD3O6DSbXN-WMA1rRG9vCs3Kg@mail.gmail.com>
 <a0352a42-15db-4c7a-ae73-8a4e1543cd50@kernel.org>
 <CAFQXuNZVE6cZJGwrGKGtWnB-seSJLHFh8zW3jjAs6U4JLZFWng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXuNZVE6cZJGwrGKGtWnB-seSJLHFh8zW3jjAs6U4JLZFWng@mail.gmail.com>
X-Proofpoint-ORIG-GUID: MktiC6tuKlNRzpUVfr2WHLR2IYex0gNu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyOCBTYWx0ZWRfX3rJC2Ff2kzqO
 LlDsl1CXDlEEz6gwq0NL5zzSGRcUq9bIE990JbD6zWPkJjRfqkr30KYwunIAEvtuG4DDG2q4kZQ
 gRWFsdoZBGx3ZiR/IIWVE4vpjmSpbs8=
X-Proofpoint-GUID: MktiC6tuKlNRzpUVfr2WHLR2IYex0gNu
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3d41cd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=Kz8-B0t5AAAA:8 a=bzQWwWhvmsQFf1HMtL4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyOCBTYWx0ZWRfX44ll1r5FZC9q
 ReDDyIjz0tmH7KNay86Z148I51X4kBKok5+x8Cm8oQjgcMZ1g6PW6PtCKgj1laQxRlO0Pf85lSw
 D8OIwW7UDT/98z30tnLF11S2043nB4WwYKe4N58Lzx/57Y26YND+v91wGhNNyptgng8qkRUmpUp
 L3dDjLjB4L71UC8O+t7JjRUQBqgdCwuPYf1Hp4SRQZXWj88DObIfaa1jwRqzj52ZqNkY4EuKnJZ
 bvNl7iR70lOHqSHdbIsU5U5lW2UuZEOzxBiNzEdd2zfxKl8trDipOA+tjDrvm4ITaszMI8YgVMj
 9u7TMvdIoXxlhy2fbeBRxTFyQqzBmn8zX2A3SZ+lyXd6KdUXkONwZQWtVSXtbsQrrKpjji5QiDp
 R6/5cogUTj4+jeSFm8AUoYqEcN2xMPUQgpCrkbtiB7rS7oYiYz/z5FxqTFevU9SISuDqribtPXB
 qZRAMW4NrvA8wH75udw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250128
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

On Thu, Jun 25, 2026 at 09:26:47PM +0800, Sunyun Yang wrote:
> Krzysztof Kozlowski <krzk@kernel.org> 于2026年6月25日周四 21:17写道：
> >
> > On 25/06/2026 15:14, Sunyun Yang wrote:
> > > Krzysztof Kozlowski <krzk@kernel.org> 于2026年6月25日周四 20:54写道：
> > >>
> > >> On 08/05/2026 15:40, syyang@lontium.com wrote:
> > >>> +
> > >>> +static void lt9611c_reset(struct lt9611c *lt9611c)
> > >>> +{
> > >>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > >>> +     msleep(20);
> > >>> +
> > >>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > >>> +     msleep(20);
> > >>> +
> > >>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > >>
> > >> This is just plain wrong. Why do you assert, then de-assert and then
> > >> finally assert AGAIN the reset leaving the device in powerdown stage?
> > >>
> > > I am using software to emulate the hardware RESET button on our EVB.
> > > When the hardware RESET button is pressed while our chip is running,
> > > the signal level changes from HIGH to LOW and then back to HIGH.
> > >
> > > Of course, we can also use the following:
> > > static void lt9611c_reset(struct lt9611c *lt9611c)
> > > {
> > >     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > >     msleep(50);
> > >     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > >     msleep(20);
> > > }
> >
> > Makes no sense either and you just did not get the point and did not
> > answer my question. I asked WHY you leave asserted. Answer "we emulate"
> > is just plain wrong.
> >
> > So again please answer:
> >
> > Why do you leave device with reset asserted?
> >
> 
>  devicetree:   reset-gpios = <&tlmm 128 GPIO_ACTIVE_HIGH>;

It should be GPIO_ACTIVE_LOW, if the pin as active-low.

> 
> GPIO_ACTIVE_HIGH:
> 
> gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);   ------   reset pin
> is Low level : Clear the register configuration in the chip to stop
> the chip from working.
> 
> gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);   ------  reset pin
> is high level:  The chip resumes operation.
> 
> 
> 
> > Best regards,
> > Krzysztof

-- 
With best wishes
Dmitry
