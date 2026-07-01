Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24EFC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2868810E261;
	Wed,  1 Jul 2026 20:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RKHTLBLS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA85F10E261
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 20:54:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E40E5600AA;
 Wed,  1 Jul 2026 20:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951871F000E9;
 Wed,  1 Jul 2026 20:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782939256;
 bh=JEvy1l2R5wDaP3nl/PDDWtUqdSpWWifDM/0zHsJVrRk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=RKHTLBLSHHyOozZaZ1oQqP+Uqzxr0ZaN4FhdLEg55Vlc14sB7aSatfHYl67twCv32
 Cv4q7UmX6LIZNbmMcwqATcgo1qliognvxVvKTamcG5d0630tD/x43lIahjoMWhx+Rp
 gaJabrPG55p62aLzweL6lOiJXvTmkrvBmv//IH8wPCYpTF8WfgL62F44i9Ds1QORnH
 nBYk9moXy3mJuDN8+k7Ri8hhI9uGDQr0EG+9z9pPOV5n/J23qn0DQzbMR5WczuPMjd
 jpGc9Xlu1kCS3D9O8E3IdXOOesV7agMCpVQ0TKNJt6EgAJeWdeoTclRNCRwqZDNE4/
 hsyFsCDYKEF3g==
From: Srinivas Kandagatla <srini@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: gregkh@linuxfoundation.org, ekansh.gupta@oss.qualcomm.com, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260701104821.3120719-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260701104821.3120719-1-srinivas.kandagatla@oss.qualcomm.com>
Subject: Re: [PATCH] MAINTAINERS: fastrpc: remove inactive maintainer and
 add reviewer
Message-Id: <178293925536.12403.7742897817429365778.b4-ty@kernel.org>
Date: Wed, 01 Jul 2026 21:54:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Wed, 01 Jul 2026 11:48:21 +0100, Srinivas Kandagatla wrote:
> Amol Maheshwari has not been actively involved in the FASTRPC driver
> for some time. Remove him from the maintainer list.
> 
> Add Ekansh Gupta as a reviewer to reflect his ongoing involvement and
> active contributions to the FASTRPC driver from the Qualcomm side.
> 
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: fastrpc: remove inactive maintainer and add reviewer
      commit: b070f59a58df9f98e6439025cab3aaa57fa98ec4

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

