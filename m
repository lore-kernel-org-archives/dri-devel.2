Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F84C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 07:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 585F410E414;
	Sun, 28 Jun 2026 07:49:31 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7901910E414;
 Sun, 28 Jun 2026 07:49:29 +0000 (UTC)
Received: from smtpclient.apple (unknown [117.182.74.7])
 by APP-05 (Coremail) with SMTP id zQCowAA3xgn_0UBqHnO7FQ--.53219S2;
 Sun, 28 Jun 2026 15:49:22 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
Message-Id: <E91B74F1-B7B5-4EF6-A697-634178A2F3A7@iscas.ac.cn>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_49C0EBF9-8A71-45A7-AC34-64A2972B0D6E"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v2] drm/amd/display: set new_stream to NULL after release
Date: Sun, 28 Jun 2026 15:49:09 +0800
In-Reply-To: <2026062816-contour-womankind-1646@gregkh>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
References: <20260628072740.8884-1-vulab@iscas.ac.cn>
 <2026062816-contour-womankind-1646@gregkh>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID: zQCowAA3xgn_0UBqHnO7FQ--.53219S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYD7k0a2IF6FyUM7kC6x804xWl14x267AK
 xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
 6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
 1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
 0487McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
 0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l7480Y4vE
 I4kI2Ix0rVAqx4xJMxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r1q6r43Mx
 C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_JrI_JrWlx2IqxVCjr7xvwVAF
 wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
 vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
 0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
 W8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjnmiUUUUU=
X-Originating-IP: [117.182.74.7]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEMA2pAiop2TQAAsT
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


--Apple-Mail=_49C0EBF9-8A71-45A7-AC34-64A2972B0D6E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2026=E5=B9=B46=E6=9C=8828=E6=97=A5 15:33=EF=BC=8CGreg KH =
<gregkh@linuxfoundation.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Did you forget to include an Assisted-by: tag?

You're right, the Fixes hash correction in v2 was suggested by the =
reviewer in v1. I'll add a Suggested-by tag in v3. Thanks for pointing =
this out!=

--Apple-Mail=_49C0EBF9-8A71-45A7-AC34-64A2972B0D6E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>2026=E5=B9=B46=E6=9C=8828=E6=97=A5 15:33=EF=BC=8CGreg =
KH &lt;gregkh@linuxfoundation.org&gt; =E5=86=99=E9=81=93=EF=BC=9A</div><br=
 class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">Did you =
forget to include an Assisted-by: =
tag?</span></div></blockquote></div><br><div>You're right, the Fixes =
hash correction in v2 was suggested by the reviewer in v1. I'll add a =
Suggested-by tag in v3. Thanks for pointing this =
out!</div></body></html>=

--Apple-Mail=_49C0EBF9-8A71-45A7-AC34-64A2972B0D6E--

