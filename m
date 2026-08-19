Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8CBC5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E57610EF5A;
	Thu, 20 Aug 2026 08:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="akQ1Y0mR";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2271410E0B4
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 20:00:34 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ceab75934dso17080505ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787169633; cv=none;
 d=google.com; s=arc-20260327;
 b=ns0iIrh5jVszt5fwf2zEzG8YYPhwH+trkHnnIkuc4/q8HM4bqG1xFOHMSTP/ZsUY1y
 eWmVg9x/RX33KgudhgMyc8H171irb0zf77L/iRXjoismVZFyi+MNWollFmRwdtLxbG2p
 EcNzTHubwKx30IFRBmfk7iJAxFqXiFJ0im8fhqyuQaZBoUSaJFfLOT87lK4t2O/fy3kG
 NLAbgrSyRKBIq1LMLBpL3Z/omSlTu9ENhDFnoodYeBmb2ENnXuS6eji3ODNZ7kd/mSx3
 mQN8jUrGhXb1j+FY22Cnhwd4R+QdcAbnUaA/kZY+WCURTJ5l857mjAeQG4RLSUev4gOe
 vgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vIDvQ1BYL5+L/acX8gVrRxrqnuz1ZgyTKSzf8gbt7No=;
 fh=gG1xFyIeoKkX+YMz7ePxOqyIp6GZrjoYKeeJfnAogrA=;
 b=h0glIsupYfmRaK/cDGr5tU3Ei7lz5OZ2/XuecZZDTRvWNSs/PgbfOegDFcMomAfyOt
 ZVopE+Wj5fAdxc1Ah/y8hIBpk8fva8Xe9hoUqYjdO2ct/MomYSeNOrjNISN2JHeeEIhY
 jW8PSa6u26Dv7zVWiYrJMtOEtarHRvGnogBEavCBct8X9FW6T1Vo2xAO5PpRPlqL6lj7
 YLKt1D4L1cxbkKNg0b2JkRR71oIPAtjfsnsSoLLHVu8zNu88hk3yRBLnmWIqP/bKuvAp
 sViCROrnYzvAvQLcJDZVpkCj5k5XItpsWE2r/VMBkqgEJdfU55L7JHdnG24Si+X3feHe
 f1mA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787169633; x=1787774433; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vIDvQ1BYL5+L/acX8gVrRxrqnuz1ZgyTKSzf8gbt7No=;
 b=akQ1Y0mRoxTUi/pD9Z2k9kTRbxUbkwinChwWTNKGRV9TyGs1cc+2JBXSXFlFjhl0uN
 l37FQXA2wMldfqOQ8T+WaHeIJ5jho4/h9UEOBFROKI5I8AIH3Y0ywpmMbrCMQiGTnKHn
 OMlMat29h+9ztzlzZis9p0ZVOPiCpj4kjnNp1rmcAd884pjCQV1URuf0FafOJF7MCqKI
 xo7v4IRWzv7zWHbkW2TWMqyUxRw4NPIQI6pAkykt3374+YaCJBSiBdFyFI5+xi7zjW25
 LjCO1lke8BproBSONB9cm9er1XJutHG2VBW1a8n9wFehGbhMzSvXLgLnyxGgJa4joKBK
 N8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787169633; x=1787774433;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vIDvQ1BYL5+L/acX8gVrRxrqnuz1ZgyTKSzf8gbt7No=;
 b=A1OLgU0SFGLipkhV9g7/lNj0BVAzTP1TtzyEjUK+m5Ax5ZXOu/N8MrcWLESJIo8EqH
 fATNiv4RzWkCSbBGz8yt+lquzf6R8mXiDthsH7s/R0TsFUJ7DNXK/h40wnV84b3AbONT
 nbg3Ic6jiNsF/rf3+eP2EvSgcZRBt4ooekpm+idN+VIhLZ2WY/8mK9dJpI9V7RsD31Ca
 zcPnOr+bcNuE5BiiBUTpJuV3KZLr+YKvBksHcgHvhyKeDqFNmzbk3HnGIIkCobV5hYL2
 Nj8wHDqRdQn086Iqa6fpkHhBm1ist/uEy7bhI5ctcFIVBE8E6WpcB4CvPzuGRyI3Yzaf
 1Wzw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4tnD9ybdsu3MrcFEzOEffbQkcLhy58OjnC9PjzEoixje0qIw3FSzYzdvatYX+eQwQh/s8oQZyoE0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mGx02khCbPS2sO5EGXlDBcHDO20ywUZ/Hg3SsIeJtICDwOrZN6
 V5UcY8a6cm/oHn31ZrGmz1wFxCBWzRwoFzYIPMLqvJw4ZpKHPyPYs3wJ/W2TxZwSFSKCRvi7z0b
 CbVPlOUIM/F+bvdUuRQXgIj1hJ/Iq7ik=
X-Gm-Gg: AR+sD107RTe182dVtciDE5PqOycTfMqkS5GW5To+e9G99VIeHx5INv3dsIyXx1Kf/oY
 QJqMAsssykwsjZyrKC//kj8OQG0l7PNzzTjNEyC5Hvx+Gae6kTTGrjZGrb3ixNdrrvFeOr4IUeu
 CJESaLfnZo8ZR7m0Fx8CrRoqHbFrvtzLwFuSTz8jmk8un5idw3V0GBDoduaMSdmVNK8ACsoXBdY
 74mBb4y14m+S4H7tACMgTyry/BEXz1mE56ORsVnR16L3NZCNxIUNzElxLaAn4DbHglmaJ1e438e
 nXREM/pi7DB2+balhWAaHHCMiOLOOudx7vgmwFqt7f98UW9EYnyyKjE1BCDuGekfLe6222EMDwy
 wZkaQhSgmvWKrPg/eNynzdYHiIs36SvFgzwnYuJ2P8fwwnQc+6CQ0wGxYCz+lRI4=
X-Received: by 2002:a17:902:e541:b0:2ca:ecf6:910e with SMTP id
 d9443c01a7336-2d5fd38fcffmr113795575ad.0.1787169633345; Wed, 19 Aug 2026
 13:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260808171321.133028-1-jesse.casco@gmail.com>
 <9fab8686-d0fa-40df-a6d0-75349861d78a@oss.qualcomm.com>
In-Reply-To: <9fab8686-d0fa-40df-a6d0-75349861d78a@oss.qualcomm.com>
From: Jesse Casco <jesse.casco@gmail.com>
Date: Wed, 19 Aug 2026 16:00:21 -0400
X-Gm-Features: AcwNN1VvGTpq-Un825CS9Bo5iwfRmFgQWXNI8QlDt_2Z2tzb9vZb1doA9jCY3Ms
Message-ID: <CAEaxeoRkYMQagxz84zNL+L4iO3s-KZFDOQ=LLU9UmPnO4o4hhQ@mail.gmail.com>
Subject: Re: glymur eDP PHY (v8): link trains only at HBR3,
 all lower rates fail
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Abel Vesa <abel.vesa@linaro.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:48:42 +0000
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

Confirmed working. Applied patch on top of next-20260819, panel
trained natively:

DPCD 0x2201 ext MAX_LINK_RATE =3D 0x14 (HBR2, the panel's actual advertised=
 max)
live link: rate=3D540000, num_lanes=3D4, bw_code=3D0x14
2880x1800 @ 120Hz, 24bpp, pixel clock 709.633 MHz

Thank you for this! Happy to test anything else if it helps.

Jesse

On Tue, Aug 18, 2026 at 6:39=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 8/8/26 7:13 PM, Jesse Casco wrote:
> > Hi Abel,
> >
> > On an ASUS Zenbook A16 (UX3607OA, Snapdragon X2 Elite Extreme) the inte=
rnal
> > eDP panel never comes up on mainline. It is the link rate: the v8 eDP P=
HY
> > appears to bring up a usable link only at HBR3.
> >
> > Tested on linux-next next-20260713, next-20260803 and next-20260807, wh=
ere
> > phy-qcom-edp.c is byte-identical -- so not a recent regression, and the=
 May
> > 2026 series (eDP low-vdiff LDO config, unified swing/pre-emphasis table=
s,
> > eDP/DP mode switch) is present in the tree tested here. The sweep below=
 is
> > from next-20260803; the machine has since run next-20260807 as its dail=
y
> > driver, where HBR3 still trains every boot.
>
> I mentioned in my submission that this series is required on top:
>
> https://lore.kernel.org/linux-arm-msm/20260622-glymur-edp-phy-v1-0-814b45=
089ac9@oss.qualcomm.com/
>
> Konrad



--=20
Jesse Casco
