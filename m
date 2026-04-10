Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2FBF459EF
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF5110E9BE;
	Fri, 10 Apr 2026 16:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rVroaaV3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rVroaaV3";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E73D10E9BE
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 16:48:01 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PHod9ye0+2F3h4HFGS0iODGChteWaZvZEiICuc+e1sMvKmW0wKx65Ez9FbN+noCh1fy+AAGNZJgBG10ZPJx+OmFem8n8PE6h2PoVHCOMP5Sk+PI856dD4RtkJDlx/X7qEf8HzL5iEmWlBfRrVLZWXBpMJLBNGS/ZGvjtauAriyi+ZQ1QXqPPNRNkC7lwZTHpxWk6cAs04oeOpmxPRmmytKbVJDiNwIe4Coix99x41QZTE9AJJwLL/R2M6IXPRwmyQy/gPmhB7XPvO09khO2CJIZNkGOUxQ8XOAlZCexPZNN5kxfmQWRaXO6S/HSV14VIcwMzfjt33KhUvYchfaow4w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9Nw3ZEPnE7MPHZvs/68cAR8m2zWNbYyEw0xbO7Zm48=;
 b=Lbz72s+ckPFs53BvBwguci0/X1XwoJI2JslhNWVQWpxxQrE7XP2DBE8nj77RQamgr7aJGMUkpuTZQnHgv5NM669ZRAWz8ZbK4YKa7yKgSyf5s2Irr8kDCOFhbGUvMgcX4Fga4eCYfkQpKVgWDXlsIlnuzfUPdPRMswIZDHzX2OuQkhQAlGix81qSUTz5u7laT/skBt6YX93t6bJbwotnCYKb3cAne2Eh3WhisJkNdLbmnPpa4+PfzP1acf5p82YeKfh9UfnBvrNNj+TMpmZinrgphspqKj3xxVZ5H7Fi1gWdOMs8tKrLI7SV9lQNx+PXiQHmnTlk7Fu/SHprp9AGSQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9Nw3ZEPnE7MPHZvs/68cAR8m2zWNbYyEw0xbO7Zm48=;
 b=rVroaaV34fQXD5u02G0id5kK6BehW80glVt9cSKHykg0AMVeXzUh1GSIEosMHXIbcLlL4GQr4yCYmAzSGU3HPEkLwumEKNfcciMhEjq+voQk5jh/O2K+dLNmHaYJb7+MIu9u62RzyImqbNc6ZuaSKOGaXIF+gjPUJcHDG+/bnQw=
Received: from CWLP265CA0505.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::14)
 by AMBPR08MB11617.eurprd08.prod.outlook.com (2603:10a6:20b:736::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 16:47:56 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::18) by CWLP265CA0505.outlook.office365.com
 (2603:10a6:400:18b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 16:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 10 Apr 2026 16:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXw4pTBCAEgpBnmUpUC1UhZK2xH9jB73Y0ONpIBQSKIAcnluza3DYruB83vzv4TgfWhQTUhpR67ZgafiviZFpmlwePncTxWdO8A2NBRjGAxskHNc8oYm6dFYGXRm9wZX4GAnklwpuEeaaBzrBudjfSNUJWnPVQTYw3ZoOnlrWoJO6kSt7/Jlw5CJCbqOGolvUW6TE1fn33k1n4KohAHBp5djzZPCArPUBo/bZ/5obkP2SYSPQu4kEx+qvVGau4Feq7MKtT/Nzz72Cy5vNmA1IOUmMYPJ9S6MUvMhmYhCMhhOVHtQZ5Xt+GHCvk9oMMEGkBeKkC9caWUK7Mjif0QySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9Nw3ZEPnE7MPHZvs/68cAR8m2zWNbYyEw0xbO7Zm48=;
 b=nUuzlsVOtps8cBHZyd2/otIbPnX/yezk4UEuPRxgjnoNtMculnUtwOgwN/4DxoxEgASv56LNBrotEV/GRJn4RHNdDkabXL0Pwp3z5j3ZxE+OtYSekcxeqHD6q9uLv8sQgIQn/Keit9kjfoJGhoEV8QNq/5FDpGkgvBeYq9YzmD7QR97+HL9KQ/CYC1L1UzYj/14j8n9KYR3V+ZMaHw6FEf8wK65mf7fp3dGauwJo0wu+JsmZM6M0uKl10KterxBf5waUD1AHZIqYTa9MFFTZUTAPYHB7HF8nb/Bfm4vTALx/VuslWTtM3ZEdGQFG3vaq44VPjazOjDQZWVKV+fU1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9Nw3ZEPnE7MPHZvs/68cAR8m2zWNbYyEw0xbO7Zm48=;
 b=rVroaaV34fQXD5u02G0id5kK6BehW80glVt9cSKHykg0AMVeXzUh1GSIEosMHXIbcLlL4GQr4yCYmAzSGU3HPEkLwumEKNfcciMhEjq+voQk5jh/O2K+dLNmHaYJb7+MIu9u62RzyImqbNc6ZuaSKOGaXIF+gjPUJcHDG+/bnQw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS8PR08MB9624.eurprd08.prod.outlook.com
 (2603:10a6:20b:617::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 16:46:53 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.016; Fri, 10 Apr 2026
 16:46:53 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] drm/panthor: Use a local iomem base for firmware control
 registers
Date: Fri, 10 Apr 2026 17:46:36 +0100
Message-ID: <20260410164637.549145-8-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410164637.549145-1-karunika.choo@arm.com>
References: <20260410164637.549145-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::19) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|AS8PR08MB9624:EE_|AMS1EPF0000004A:EE_|AMBPR08MB11617:EE_
X-MS-Office365-Filtering-Correlation-Id: 586bdd8f-5095-4914-094b-08de9720eabb
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: hGRmQdyB+A0+/LpGpNMD5hRmQKpf0cI2SU0tIRJD1IOAZ373aCrM+W+RolDBBlbVfvgjUtWuk7+T0KdXHofXyRJoy5WZRseF0exCgA/dZrP/U2AhmjxxnjfiqOc72Ta+rRB3fhARggsMvcaNrffte4CrTyvQGyrE+Rj2sC+5TeKHASaX1UPg3o/ciubot+Pj9SD6ptxZzp+eGuVkgawur4nX4G5C6e6jM4QViC4FCgWDV8c1QxEx+pxvu2eBNeVhZdQNnveps9hDzaBeN6b4lMUnMXLMn8zcTX9epa22ke9RuT0qcW5T8HiIgqUPOy3qPo6/KmZRbzcEh4m09eLzihTlqoPr1AUMyr4itg/vvq9cJBAiJ/hZc2pFmy23YSmW9LJ0qvTZ+P+b8RO1LN7hPGCDXYO4oD/qf0WHO1GqnV+w0LGrwMBpAa0lTVU//bzT7By7ObKAAS/dwkr1rCO+tNpY1q9Tq01KI6YwzJbnm2F00wfv1gWdiOl6tAWSdqXkN5QWweb7Y3T+Y8UCBWDpp6LJB7P+rlHfWeK0lS9WSbZ2My1so0zOpVrRYO8j8d4tn80lX7L6sdSynkJHbEVj+qYgkKwfYqrLyIRJpUsR+hIYrpKCn4cTzOKJM2qic4eiexSyOPJk3RFY+ppVFCqMbp3v524uJugdIzKX2sEWRG0k9V8G6t2NWjdctJ9Fk9yUfMpkPNn8lJFtpPH6s4GaDRxfiZCSwPD0ZSihCRXwXaE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: W5vk2uLMKYQunjTcgwxlpR6wSWtnrwVUBcRVfe5pLAb5kpWodW7Ljsz3VZbgdQKE5Unrh4Pxc5bxztHax04Z+X77rLF8fLdgtZyWRePii/uQkdIaKNoA2aQW1W9N3wA3CeZamc5ZRZkwuYnWUJZlTMx26jDM13fnF6csLImKGWdzcrGs3L/P7uqn/hUwHGouChmMFjf/maw8Bfdsgavier3HRsIUeHAUxdly7AYsKbtW/U72VrzuQTI9z2KGeHK7cnKecPUuSECoOtxG1Q4e5yHMW6DoRnePnFFLyXDBb+D+BRvIL8VBDDIe6WwkNplAIsQP9ImNL5+5RvuAJDMLXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9624
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fb58be57-ee0c-4196-ee58-08de9720c37f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|35042699022|14060799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: oIfw9mqzGF8CAV8vbjDlQpZc2vysvAtA0eXM80XpftkzcUUXwxOVQ67Mn5TbzAEda3DuGjcuxq7ClfCX85LgqSX/BFksDPzyO1EZU+rjicKNMErZfNsftXyeWdfTFFfMY8XG6BZpjGEShQWH5U3K8HyBciAJ+k0xTc5Ea1s2bcsl3+Pc3cwalWGLhvO9mTMqMcYkclJ6EVw+s8Dn06s09lfZ/I+r42+wB1ysfRzXI9LiA9Pvz1c9ZzVxp+zeKkXZb0+THBDxExzTVbxYPH7yP0JX+zrDh4AifnieSVoa0CW4KlPqVsW4gkMVjrCU9EyG++u2kUm43sn1kjoenngKhOsIX5anLsYEgT73QNdKHKcog9uNPg6gsbgWCSq3ceFrSJi7r/M/pLDZK7lm/y2wr7rPluJ88OJZpHMwrjPWKe6D4YOC6UJOeLTp8d3B7qqLqmlMabsDzsyInLI5S9fS1Eo2o6F8poixwF8FUDP3sMbPA+H15o0wndPa0I5wHGQNThyorfK90WEfhQuJo7nltiWXz2O3Cuj6oG8msqmXDo2uaVcNhIfndrfJxfpkxz+IReI7x8I6XUkkHJ+K3fRxV5f02P8FKEQtKLZnpByVs4qeIiUuC2BQgp/FOr2Sjg2xdTPynyJVJ7tWT86m1bDRoL06rRvqUPRY1GCQuYjWdZlm/h12gC85hlMGENeiqT7k8c2064NBBOSqBhfBWDtyOgubVb+yRjwLQ8iQgQMZJ8a3aomilmggDB+eUkzh16997ha6HcKfI9k8PVSUQH6MJw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(35042699022)(14060799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W55h04tdt9oE9IshvPh9mPp1Rmds92sxQR7fkeHYQU4GdoTt1OZioOWmE5uYI8TxV2P0F0IXmfQPY+TMMQPtuuBijrBZ8Aea8cS7cFUPXDGIOn/pgx6NXWaL51MCl7/zp2vIVWgomYsYJWlFIIUc+R9GVNJIOAE26sz9diWEW8jJ8AwUv3q0TxlwiPuXo3ZealQ3BEuE0bOR2R2mhs6du1m1We2GZdp5WKvKQSRm6IxoKez9YTIC4kRp11uBZigDOupd42mC1Khd5M0gHyDuyRd2jqll8fzZ+UFfYB8jt0G9a0QRkDvdAAKRulzZWT2Cd/Cbq+WHbslIqVfUVunDCN+TmgpZ1Ptbbn9O6+7d9F4Ev5r1MmEzOOK1leo58ZifNNuj07cq1VZ0tRyg85Dy/l2tvI0JG7ka34laB85PDMORtUPyppWwwhKOJjGfBkBp
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:47:56.5174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586bdd8f-5095-4914-094b-08de9720eabb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB11617
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

Add an MCU_CONTROL-local iomem pointer to struct panthor_fw and use it
for firmware control and status register accesses.

Job interrupt accesses continue to go through the IRQ-local base, while
doorbell writes stay on the device-wide mapping because they live
outside the MCU control window. This keeps firmware register accesses
scoped to the component that owns them.

No functional change intended.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c      | 20 +++++++++++++-------
 drivers/gpu/drm/panthor/panthor_fw_regs.h | 11 ++++-------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 20747f42759f..bf7c2baefb79 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -234,6 +234,9 @@ struct panthor_fw_iface {
  * struct panthor_fw - Firmware management
  */
 struct panthor_fw {
+	/** @iomem: CPU mapping of MCU_CONTROL iomem region */
+	void __iomem *iomem;
+
 	/** @vm: MCU VM. */
 	struct panthor_vm *vm;
 
@@ -1069,7 +1072,7 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
 	if (tracepoint_enabled(gpu_job_irq))
 		start = ktime_get_ns();
 
-	gpu_write(ptdev->iomem, JOB_INT_CLEAR, status);
+	gpu_write(ptdev->fw->irq.iomem, INT_CLEAR, status);
 
 	if (!ptdev->fw->booted && (status & JOB_INT_GLOBAL_IF))
 		ptdev->fw->booted = true;
@@ -1092,18 +1095,19 @@ PANTHOR_IRQ_HANDLER(job, panthor_job_irq_handler);
 
 static int panthor_fw_start(struct panthor_device *ptdev)
 {
+	struct panthor_fw *fw = ptdev->fw;
 	bool timedout = false;
 
 	ptdev->fw->booted = false;
 	panthor_job_irq_enable_events(&ptdev->fw->irq, ~0);
 	panthor_job_irq_resume(&ptdev->fw->irq);
-	gpu_write(ptdev->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
+	gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
 
 	if (!wait_event_timeout(ptdev->fw->req_waitqueue,
 				ptdev->fw->booted,
 				msecs_to_jiffies(1000))) {
 		if (!ptdev->fw->booted &&
-		    !(gpu_read(ptdev->iomem, JOB_INT_STAT) & JOB_INT_GLOBAL_IF))
+		    !(gpu_read(fw->irq.iomem, INT_STAT) & JOB_INT_GLOBAL_IF))
 			timedout = true;
 	}
 
@@ -1114,7 +1118,7 @@ static int panthor_fw_start(struct panthor_device *ptdev)
 			[MCU_STATUS_HALT] = "halt",
 			[MCU_STATUS_FATAL] = "fatal",
 		};
-		u32 status = gpu_read(ptdev->iomem, MCU_STATUS);
+		u32 status = gpu_read(fw->iomem, MCU_STATUS);
 
 		drm_err(&ptdev->base, "Failed to boot MCU (status=%s)",
 			status < ARRAY_SIZE(status_str) ? status_str[status] : "unknown");
@@ -1126,10 +1130,11 @@ static int panthor_fw_start(struct panthor_device *ptdev)
 
 static void panthor_fw_stop(struct panthor_device *ptdev)
 {
+	struct panthor_fw *fw = ptdev->fw;
 	u32 status;
 
-	gpu_write(ptdev->iomem, MCU_CONTROL, MCU_CONTROL_DISABLE);
-	if (gpu_read_poll_timeout(ptdev->iomem, MCU_STATUS, status,
+	gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_DISABLE);
+	if (gpu_read_poll_timeout(fw->iomem, MCU_STATUS, status,
 				  status == MCU_STATUS_DISABLED, 10, 100000))
 		drm_err(&ptdev->base, "Failed to stop MCU");
 }
@@ -1139,7 +1144,7 @@ static bool panthor_fw_mcu_halted(struct panthor_device *ptdev)
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 	bool halted;
 
-	halted = gpu_read(ptdev->iomem, MCU_STATUS) == MCU_STATUS_HALT;
+	halted = gpu_read(ptdev->fw->iomem, MCU_STATUS) == MCU_STATUS_HALT;
 
 	if (panthor_fw_has_glb_state(ptdev))
 		halted &= (GLB_STATE_GET(glb_iface->output->ack) == GLB_STATE_HALT);
@@ -1461,6 +1466,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	if (!fw)
 		return -ENOMEM;
 
+	fw->iomem = ptdev->iomem + MCU_CONTROL_BASE;
 	ptdev->fw = fw;
 	init_waitqueue_head(&fw->req_waitqueue);
 	INIT_LIST_HEAD(&fw->sections);
diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
index eeb41aff249b..b2e59cfc22b0 100644
--- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
@@ -4,23 +4,20 @@
 #ifndef __PANTHOR_FW_REGS_H__
 #define __PANTHOR_FW_REGS_H__
 
-#define MCU_CONTROL					0x700
+#define MCU_CONTROL_BASE				0x700
+
+#define MCU_CONTROL					0x0
 #define   MCU_CONTROL_ENABLE				1
 #define   MCU_CONTROL_AUTO				2
 #define   MCU_CONTROL_DISABLE				0
 
-#define MCU_STATUS					0x704
+#define MCU_STATUS					0x4
 #define   MCU_STATUS_DISABLED				0
 #define   MCU_STATUS_ENABLED				1
 #define   MCU_STATUS_HALT				2
 #define   MCU_STATUS_FATAL				3
 
 #define JOB_INT_BASE					0x1000
-
-#define JOB_INT_RAWSTAT					0x1000
-#define JOB_INT_CLEAR					0x1004
-#define JOB_INT_MASK					0x1008
-#define JOB_INT_STAT					0x100c
 #define   JOB_INT_GLOBAL_IF				BIT(31)
 #define   JOB_INT_CSG_IF(x)				BIT(x)
 
-- 
2.43.0

