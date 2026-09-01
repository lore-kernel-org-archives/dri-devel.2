Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4308DC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D64A10EBFA;
	Tue,  1 Sep 2026 08:50:42 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1258D10EBFA
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:50:40 +0000 (UTC)
X-QQ-mid: zesmtpip4t1788252496tc46f9645
X-QQ-Originating-IP: jAnARFYDdwVi32JHsYFw7EMsDCDcE2uzlE6/Bqeumrw=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 01 Sep 2026 16:48:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12420683238229624417
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Tue, 01 Sep 2026 16:47:55 +0800
Subject: [PATCH 2/6] dt-bindings: display: bridge: simple: document
 Chrontel CH7218A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-q8b-dts-v1-2-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
In-Reply-To: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=sophon@radxa.com;
 h=from:subject:message-id; bh=P3ecEwYp+pJD3fXjF69gnodv/MTSj8RHD4NMUnKFiTY=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFnTJjqrR7AfSJUq63m/46MtbyfjrqBA3RJ1i5436+P7X
 zzrCD7XUcrCIMbFICumyKIQzzCXvTL32lOxUj2YOaxMIEMYuDgFYCKmpxgZTk3XVrj9d8+Ohe1R
 f3lPdVcH9574uP6diM3a/ze//y84LMvwV/aDOFu6avDN2KbTmzV8L6bzmmucncLNxTn3Z5iR9VQ
 1BgA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NgMjZ6oC7N4ABod00TvdJ6Gbix+bulej41YLdFB6iz3rU0tm1S2JmD/K
 d5pStW7N45h6o6gnuJflTaR1w8AOdmYkPqsshGOEnMSd4ROhPIhPk4fH885M2tCbPMNt3n0
 eBcPjC3YZhbl95UeArla+8bmeup6HvLn3JiVCUdvlNdYy8cvi6McP28MmBd42ndPA0gMJpP
 3RCManMw+AFpTGXIcpVbmGe+WrNRUsO93Lqc6gW7EWWml3uOixJH4QWpRmLGLtj3EcxrzC8
 XQ5xW1fHNOQrrcRDq1k4t6JjgQWkuYXvEG8Vx++ihTGlr+Nbxb9dP/MYfp+c2KeksoXhykN
 IGigtTM43r+qOzgvmWvmIZyOqbZkTWr33XYWo2bSrYdUiPT2/mdtz6ojuiHS96qIF5BPyRO
 Cb9TTeKksZmAbvYxT1dNnYooPolu34YiMZ58FemQ+TN6Dzum0UGUbLTpIo++BahTTylLk5A
 MfL1h6QEjadALATFG7RPxEY3z7jGBSRTeKSzJCkPunAXv0Sg1lvRclwe2QZfoMSr4diD8jF
 JjV3pGyqW0D5o2gsQFBCwcDF4Mi20kuwUFHWpdcOrFpr0HmwfloLhgnyC1qDIZFWUHpya37
 Hutun7+Wi78YJbSg/kH5VCPBdaosZFgLEm5C+Y6i3nBwsSluF4rIe37xmtWRd+w7fWJvLcO
 Ypv08MiJzIcYP21+5FuUtLLOc0zUmV3eM+5wGFhpDtWnc0TVasRZwl0jzdrrIyK95CrrDe6
 I7CB6yYwJyYAn+NQq+Yd943eD200WcvP6pI19nLDLnCxZDGCDsPwEYb/BJOHwN3ec/emC4o
 IY+cJDMHEUw66NY312Vr6oOvYngXdTjevurI0gvoc1OzQx9GYqIvSksAdwwq/TTKRH5CFsC
 GrMUSchHYsv4L/lsKWiBBrt7oaSuIlfUzPGaHEhsda5/wmOTCzD05x0fwaf3JwAM80M8rok
 Q9A8kvBnqHOhgXHFTwPlAqQeGbUzg/NWt3KIET50uIP2atXIqsW26rSFe+PIW4L73IxQ6XB
 ltwZUEQfKVBMAQgtxhNwh7wzsyyJIIEnzgEu/F/ESQ6YEQVUSl02gOcMfqsH5OoDXnU1iQk
 ck98Q3tnzjq
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
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

The Chrontel CH7218A is a DisplayPort 1.4 to HDMI 2.1 protocol converter.

The device contains an embedded microcontroller and on-chip flash. It
automatically boots its firmware and requires no host-side configuration
for the on-board use case, so it can be represented by the simple bridge
binding.

Document the chrontel,ch7218a compatible.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
index 7636c24906ba..9e0e7e09774e 100644
--- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
@@ -29,6 +29,7 @@ properties:
           - adi,adv7123
           - algoltek,ag6311
           - asl-tek,cs5263
+          - chrontel,ch7218a
           - dumb-vga-dac
           - mstar,tsumu88adt3-lf-1
           - parade,ps185hdm

-- 
2.55.0

