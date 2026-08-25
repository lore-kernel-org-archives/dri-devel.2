Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8EAC61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 23:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E7E10EB8B;
	Tue, 25 Aug 2026 23:45:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NcwCQ5c8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E50A10EB8B
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 23:44:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 534DE600C4;
 Tue, 25 Aug 2026 23:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF086C2BCB8;
 Tue, 25 Aug 2026 23:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787701498;
 bh=yahlqdnVKdlnxPv7kgdCgJdOJCjTzFaRNEl+vby53Eo=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=NcwCQ5c8UxpB4cb/xG0fyOp/MX1wadAx+YQDMOppxoCbLdlpqD754sv4JAE5R4tsg
 9ghKu+swuEsARr5As/BLmdEkOI4UxBlWcEZVOjymIOFhVX7gvxDdqGURBEbozQwjMn
 zpXXYxa2WQPfpd2UD9lWnfA7EEc2aTX0a0QnUBW8NhWSXIE2A9Oe7xOzleACiInnpL
 nDRIUSbJHwztUiIISXmTv94kU7bTOxTfTBUPjHi2HYW9SRhPwkWtmEKWar6yAtuXK+
 N0F4w0C20eYAK68+EuwDffXbqN9VIZ1kofgRaTuCZJPTH+jemkU10zcQt1FUkpQVSP
 yXaCa4jXeQuuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C49FFC61DC4;
 Tue, 25 Aug 2026 23:44:57 +0000 (UTC)
From: Antonin Malzieu Ridolfi via B4 Relay <devnull+dev.nanonej.com@kernel.org>
Subject: [PATCH 0/4] gpu: nova-core: Extract falcon registers
Date: Wed, 26 Aug 2026 01:44:17 +0200
Message-Id: <20260826-b4-extract-pfsp-registers-to-falcon-mod-v1-0-38351df09084@nanonej.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQrCMBBA0auUWTsQ0yDqVcRFkk7qiCZhJkqh9
 O5GXb7N/ysoCZPCeVhB6M3KJXfsdwPEm88zIU/dYI09mKN1GBzS0sTHhjVpRaGZtZEotoLJP2L
 J+CwTnijYcYyOgiHotSqUePmdLte/9RXuFNs3D9v2AQPfdjqLAAAA
X-Change-ID: 20260824-b4-extract-pfsp-registers-to-falcon-mod-9eb233c4eb0e
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Antonin Malzieu Ridolfi <dev@nanonej.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=dev@nanonej.com;
 h=from:subject:message-id;
 bh=yahlqdnVKdlnxPv7kgdCgJdOJCjTzFaRNEl+vby53Eo=;
 b=owEBbQKS/ZANAwAKAWaH8SMKFRX9AcsmYgBqjijxzESK/eGaMHr+EPAPyhvYawjQyQmfITTVS
 zajJ4lOX7OJAjMEAAEKAB0WIQSDtk+wfJEhL1KFIn1mh/EjChUV/QUCao4o8QAKCRBmh/EjChUV
 /UuXEACoo67K7QxxNIrys3YxVZ8cj7nYt/S+aPbV+AWLvJ/7LFEckl98v6FIOVMwGVnwOT+or7R
 T3K8W9K+QFQr5a7FkWu5aorbO33T3UEO1wUaigdm4s2MZnIq/SWMb9N8rAzGaBNUGeDIZ1VGCM0
 SWTqZDMVKNunkErE1EHezeIIqZuxzJU7sLS7LBNYwQ4xWGZ29ibl32HAfO46JFZth5eHUdVpnma
 7/DVYcIBfg7fncPUBWZ+SlZFZoc3B/ITjY8fhKLq3d+W9QyzaxVisxdry1NNNc9eKrR1aeIcy8r
 Vog5YMLI3kHWBX7ZPEqPPm8pzBHFUIr959bW5nzNeVvfA+gQvAOT5+M1uLzneJRrQNJAC9u3FRI
 T++Idtv9CnjDenDGKTJ8tT/laBvTgV8yi1CC+09drc/tNtlsBqrprHaAuNrnw1ErgLIqJqyQ/Gq
 CYYk3HLKKhnW+03VSMfiprvAl8+RSJ+ow//FcrMv42ZLaWpWnvaXQaW6xQjF38FaEGZqaXkmohM
 AAVahj9Fde3NngKLoUxVHVDV6gwLLcByc3PsgLTXagAXrLAqwcrYWP57DY5S2EAckUsINztOzR+
 iHq+ELKfeS0yEMSpiccrtGq+maxo4X8nY0W3awc4C5dox9GhbpJvw7zc2k7RfkPsBfXz7b9G5JD
 n0Ftg577Mw28Jww==
X-Developer-Key: i=dev@nanonej.com; a=openpgp;
 fpr=83B64FB07C91212F5285227D6687F1230A1515FD
X-Endpoint-Received: by B4 Relay for dev@nanonej.com/default with auth_id=825
X-Original-From: Antonin Malzieu Ridolfi <dev@nanonej.com>
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
Reply-To: dev@nanonej.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Move PFSP, PRISCV, PFALCON2, PFALCON registers definitions from the
root regs.rs file into the falcon module.

I tried a different solution than rescoping all  registers with
`crate::super::...` by re-exporting them, hence the comment, but I'm
not sure it's the best solution. I was hoping they would all disapear
by the end of my patch series but as we discussed FUSE register
definitions better stay in the root regs for now.

Also the extract of `set_fbif_transcfg_regs_at()` change some
other functions signature, I think I have covered all but tell me in
case.
And I wasn't sure btw if `.try_at()` required `#[inline()]` there.

Finaly, If I'm correct, this series should conclude the refacto as the
remaining registers seems to be better left in the root regs.rs.

Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>
---
Antonin Malzieu Ridolfi (4):
      gpu: nova-core: Extract PFSP register definitions
      gpu: nova-core: falcon: Extract PRISCV register
      gpu: nova-core: falcon: Extract PFALCON2 register
      gpu: nova-core: Extract PFALCON register

 drivers/gpu/nova-core/falcon.rs                    |  38 ++-
 drivers/gpu/nova-core/falcon/fsp.rs                |   6 +-
 drivers/gpu/nova-core/falcon/gsp.rs                |  16 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |   4 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |  12 +-
 drivers/gpu/nova-core/falcon/regs.rs               | 304 +++++++++++++++++++++
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  22 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |   7 +-
 drivers/gpu/nova-core/regs.rs                      | 295 +-------------------
 9 files changed, 352 insertions(+), 352 deletions(-)
---
base-commit: d53bc149eea6213e9c4a4604df5521db7b7296ca
change-id: 20260824-b4-extract-pfsp-registers-to-falcon-mod-9eb233c4eb0e

Best regards,
--  
Antonin Malzieu Ridolfi <dev@nanonej.com>


