Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01807CA9EC0
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA2F10E4B1;
	Sat, 10 Oct 2026 11:45:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="ENOs0Vmk";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7A710E125
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 00:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=fa
 ux+tZRy2uLgA5HLcPYxm69xVVfboZqhcLtg+UrKKg=; b=ENOs0Vmk1B/ken0OCU
 pfjunLvqDfqb6QTDtEx1JS390GvkjHMHM7ZSeQ/U6JTPncV4N2H38Vp+HVVfxxpp
 hDjj8Rw+pOJzL12S0hbbay7AApUOmNskK9J+qew6QFu8tWX9e4YXp4cZCWv9cI0W
 J3bpqrTo0Jj0yok8pe42GKLfw=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wC3D3Rdi8lqW_JnDQ--.22135S2; 
 Sat, 10 Oct 2026 08:48:30 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: ti,
 tpd12s015: Convert to DT schema
Date: Sat, 10 Oct 2026 08:48:30 +0800
Message-ID: <20261010004830.36014-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009144434.GD622105@killaraus.ideasonboard.com>
References: <20261009144434.GD622105@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3D3Rdi8lqW_JnDQ--.22135S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw47GrWfGw4UJw43Xw1kXwb_yoW8WFW8pF
 Zxtw17K3yDJrW2k3ykAF4UWas5Aw43CFW2qrn0yrW5A3y5tayjgr9rt3yFq3Wa9rWkWryq
 9ay0ka4kZ398Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRd9N-UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-x4HfGrJi16qTgAA3I
X-Mailman-Approved-At: Sat, 10 Oct 2026 11:45:03 +0000
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

Hello,

The v5 I am about to send is not a re-send, and I would rather explain
the two things you both raised before it lands, because both are fair.

On the flooding: the v1..v4 postings on 2026-10-09 went out within ten
minutes with no version number in the subject. That was not four
revisions, it was one revision sent four times by a bug in my sending
script. It had no record of what it had already sent, so each invocation
sent the whole queue again. It now hashes each group and refuses to send
the same content twice. Sorry for the noise.

Rob, on the schema points, both are fixed in v5 and both were my
mistakes:

  - the gpios property is back to "maxItems: 3" alone. I had added
    "minItems: 3" and a required entry because sashiko flagged it, but
    as you said, dt-schema makes the two bounds equal when only one is
    given, so maxItems: 3 already means exactly three. Adding minItems
    was wrong and I have reverted it.

  - the two ports now reference "/schemas/graph.yaml#/properties/port"
    with the unevaluatedProperties lines dropped.

Laurent, on the wider point, that one-at-a-time LLM conversions cost
more review time than they return: I agree, and this series is the last
one I send on its own. The remaining text-binding conversions I have
queued are all device tree, so I will send them as one group, per
subsystem as Conor suggested, so that the same class of mistake is
reviewed once instead of fifteen times.

If the view is that this conversion should not be carried at all -
Eduard Bostina posted the same conversion on 2026-07-30,
<20260730092245.52034-1-egbostina@gmail.com> - say so and I will drop
mine rather than add another one.

--
Chaosheng Qu

