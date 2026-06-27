Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589E5C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 12:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFE910E4CD;
	Sat, 27 Jun 2026 12:34:35 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36AE510E4CD
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 12:34:34 +0000 (UTC)
Received: from smtpclient.apple (unknown [117.182.75.66])
 by APP-03 (Coremail) with SMTP id rQCowABHK+JXwz9qThsNFg--.5447S2;
 Sat, 27 Jun 2026 20:34:32 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
Message-Id: <36056DF1-643E-4AAA-B1C6-DBFAEA831DEB@iscas.ac.cn>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_B546F79C-AA21-4722-B312-6497B4DDC2E9"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: dma-buf: unwrap_merge_complex: dma_fence_get_stub
 reference leaked on all paths
Date: Sat, 27 Jun 2026 20:34:21 +0800
In-Reply-To: <5180c887-c879-440f-a58b-1cad96b7abb1@amd.com>
Cc: sumit.semwal@linaro.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
To: =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260626122836.35856-1-vulab@iscas.ac.cn>
 <5180c887-c879-440f-a58b-1cad96b7abb1@amd.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID: rQCowABHK+JXwz9qThsNFg--.5447S2
X-Coremail-Antispam: 1UD129KBjvdXoWrCFy3urW5Cr47Zw1xArWfAFb_yoWxWFX_WF
 WvyrW2qa1rCFsxJa1ayFnaqrZxX3ykXa43Ww10gr45t34ft3yDAFZ8K3Z3urW3ZF4IqryD
 KFn7G392kryS9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb28YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
 80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487McIj6xIIjxv20xvE
 14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
 IYc2Ij64vIr41l7480Y4vEI4kI2Ix0rVAqx4xJMxkF7I0En4kS14v26r126r1DMxAIw28I
 cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_JrI_JrWlx2
 IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
 42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
 IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
 aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8gAwUUUUU=
X-Originating-IP: [117.182.75.66]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwULA2o-mHtVEwAAs6
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


--Apple-Mail=_B546F79C-AA21-4722-B312-6497B4DDC2E9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 20:47=EF=BC=8CChristian K=C3=B6nig =
<christian.koenig@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Just drop that, the stub fence is a global dummy and leaking reference =
to it is harmless.
>=20
> But just in case somebody uses this code as blueprint for this own =
implementation we should probably clean it up.


Thanks for the review. I understand that the leak is harmless in
practice.

However, I think it's still worth cleaning up to avoid misleading
other developers who might reference this code as an example. I'd
prefer to keep this patch for the sake of code quality and
maintainability.

Please let me know if you have any objections.

Best regards,
WenTao Liang=

--Apple-Mail=_B546F79C-AA21-4722-B312-6497B4DDC2E9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>2026=E5=B9=B46=E6=9C=8826=E6=97=A5 20:47=EF=BC=8CChrist=
ian K=C3=B6nig &lt;christian.koenig@amd.com&gt; =E5=86=99=E9=81=93=EF=BC=9A=
</div><br class=3D"Apple-interchange-newline"><div><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Just drop that, the stub fence is a global =
dummy and leaking reference to it is harmless.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">But just in case somebody uses this code as =
blueprint for this own implementation we should probably clean it =
up.</span></div></blockquote></div><br><div><div><br></div><div>Thanks =
for the review. I understand that the leak is harmless =
in</div><div>practice.</div><div><br></div><div>However, I think it's =
still worth cleaning up to avoid misleading</div><div>other developers =
who might reference this code as an example. I'd</div><div>prefer to =
keep this patch for the sake of code quality =
and</div><div>maintainability.</div><div><br></div><div>Please let me =
know if you have any objections.</div><div><br></div><div>Best =
regards,</div><div>WenTao Liang</div></div></body></html>=

--Apple-Mail=_B546F79C-AA21-4722-B312-6497B4DDC2E9--

