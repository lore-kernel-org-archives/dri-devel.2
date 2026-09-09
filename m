Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED74FC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF6F10F107;
	Wed,  9 Sep 2026 12:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="oSUnbX20";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oSUnbX20";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB4710F0F7
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 12:37:22 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hFl/BsmcnQ5Xhyl6hxp8OnQh6f71JYv/dD8Yp9w+t/22mk8eEVSrRmA5jJa9y7kfMtAF0xND4E060Ga1z5sh5BdXyY4oi2XethNynqAF7oI+LvQ/ptdTTkvYhARtVEYvIs7zRpyUrVoq+Wn7OTd0/gFdl8lf5cBAM3L8Fj5cWCMPzXQ/hxrm+jolb9i0JJT5045+/dzVlEO5HHc/8uY3NsmudEoUp0xBKi08zJOt6Jj2FfD1hYjmkvuGjmjIqAWzuVyUaqEOWlpVgOi7z0tGq2H2u1vGTHkNdO3ikMGIbh9hdrKvIUQOfZigt6XnYGr35jhKgJhpfjRTBvu7hUPV8w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0q9z/B3zIPJSgpMBW3ZWwIQGOrXDrbr3zv9NG6exMU=;
 b=oswDhHyG122RG/4ksT5gLFBmwGGxFZINFmfZgDAdPDNsOIGXpnoUBbp2L7338DLSOPum0RdCGzOozLo9St81y0XZfoIj4S4Oy5dPhWsqv79eYfLfvmjZtHweSeeZa2gb0zIQ0K85Px1C8E6FD7pBflSfhdXc9fnIKLXFFEYZUXp4OioGHAjENLXaADopThqWXoHVuJIYlXAsk5KNHl7PEH0V+gSqKVnlhTg+3GNZVrvt/1owuoUR6pTaoOC5nJx2gLB3ftB3QQdZEXFE+rS7/elMfVYY+DuQwqnoorZ6vcZ7Z9IBEnVE08nCYoNzyq4cf3jEaCQTU9RC5P6L4AeMGg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0q9z/B3zIPJSgpMBW3ZWwIQGOrXDrbr3zv9NG6exMU=;
 b=oSUnbX20HEWf3qw9Nj+jeqC7098bH3koU7shqU50OBuKIRYIANORePlfJo7CgIYf2FxXw7HJMxcYRKT6ji54rFccQtG4skDr0SHnQFq4XUp3aD2t/9NkfQczVuPCXdreOnbp7JHQs8Ov2c2p8O3wXcrUCq+VFHVvuUxVMltdkBU=
Received: from DUZPR01CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::19) by GVXPR08MB11096.eurprd08.prod.outlook.com
 (2603:10a6:150:1ff::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 12:37:13 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::72) by DUZPR01CA0055.outlook.office365.com
 (2603:10a6:10:469::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 12:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 12:37:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpSiHI7q9EoQuR3tLzkZ6cvmJCriHGNV8rS3r6dnlhkG196ra8FR7fBI/yw+cIzVIDsS+Fqm0vQd9gyKHPviyvE+wSNytwF7wN/Lim/EOOLr/m6TbvaRcnPwXimnFBmSlolQBoNMImb0atvaQlKdkri4HbTVy0OkhxLr6LNBXoh3MFRyGUL7nyGlguo1aX5W2LfrQzpodX5OUmp7U1vFhzVzOUuioMRyvm4qEU3xIVoEcKHFlzy0dAx+J9r+0y9B4Q0SzU7F1of4OHdhwQg1M4I5w+IiL6ahVAGOhbik5QzAisGGH+ueq5jTnDxvvZ+DlAZEsabJUuUbZluaip4nqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0q9z/B3zIPJSgpMBW3ZWwIQGOrXDrbr3zv9NG6exMU=;
 b=GdqrBzQjjjTRpcQD5U41nXjG4bInSvHh6cP/8n7cFRlR5WBLLn6gsfREiMUuJlpl9KoyQ5QRoG7C8UdQmYogx6JeJeNUKbM/liZSyDnHA6IJ+AZWg0fMISB5ZWw6e0p0KSFw3BmKuM0UC0zvXJ4l/YuRhzF67y2Ebe1RC6/BavuqULInvx2djGgv7fVvmWoyqTsGnagzn7HjgwNYbiGrWKCoaz0k0hYAmhDv3qPKfjreIFg11SseZIYIwxWlnGCFkEEqvX/QnhRZS5uu5LHvMi/Z7HnYJsdaxiG7GDwAGufx52IdSjdW9jZvBQceaHmjLekQ8ekiZ088zAGXX6gc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0q9z/B3zIPJSgpMBW3ZWwIQGOrXDrbr3zv9NG6exMU=;
 b=oSUnbX20HEWf3qw9Nj+jeqC7098bH3koU7shqU50OBuKIRYIANORePlfJo7CgIYf2FxXw7HJMxcYRKT6ji54rFccQtG4skDr0SHnQFq4XUp3aD2t/9NkfQczVuPCXdreOnbp7JHQs8Ov2c2p8O3wXcrUCq+VFHVvuUxVMltdkBU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by PAWPR08MB9781.eurprd08.prod.outlook.com
 (2603:10a6:102:2e6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 12:36:37 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 12:36:37 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Wed, 09 Sep 2026 14:36:30 +0200
Subject: [PATCH 2/2] drm/syncobj: Use scope-based cleanup for eventfd_ctx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-efd-autofree-v1-2-c6c3c19cc702@arm.com>
References: <20260909-efd-autofree-v1-0-c6c3c19cc702@arm.com>
In-Reply-To: <20260909-efd-autofree-v1-0-c6c3c19cc702@arm.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Bence Csokas <bence.csokas@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO4P123CA0087.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::20) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GV1PR08MB10455:EE_|PAWPR08MB9781:EE_|DU2PEPF00028D06:EE_|GVXPR08MB11096:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e795de-4e6c-42c6-89b0-08df0e6f1343
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 073pPgENxtuEpb12VTSt1DZTk1Pwt5pkdK8XTj+SJ9AoNypkZLTYq6XLj7Av99PR3ngHfZ7TC5NKSDn1nylAQCr5MnfJClOdhtThHuv9NyzI77oB5Mdd65eaon+NVlfQgLtHeL4NA7grqyz2UFcp6r1vSpMarSXgjL6tbcgk4xksQB1yKq5v7VBxtaI/G3I18ORS0K5TOtUwJL2KXxZWSuqZWIojMShHwMYuitwzaUdT2/XX5deCW2N7/XWnHDRBjiqAYR0OfeQ+ELB/8t8K7CkWW1OWavDoW2IZXimVzeunu2FgZGiPbQOoPVRnEmL2fuduP2G/QdQGSUMvExBCR0nN+HTvq8XDE1EVWbF9n9q2SF+Blc9L5XjYw45qqCKnQB/59RMRhO73N8Qobyq+/k3G5tDDku++4K0yUKA3b/flvnZNG/8a5ZFalmbouFiu0QcpNG1QsFL2O6YmIu/WjOjmnV87tlIStkYCL2UdTVUc+A5gQC1X5fP2vuZhafGRC6j3aJaWRmtjrXBBvVBwE8R23zORiozyX7HhUj5HdrWkL2c4CAuRdy+cDtP44woINHqeWZYGlXAro9H6WnyUB1UhuLIuObHyrZSAbipUO5MnGD/VaikySjuKFVcEMLXA7YRbXd/O2fiuxRArNRFviF0zGNCniigZPHCyyU7eT9A=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV1PR08MB10455.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 5mjkzGeAP/JyZ9PQ/PUF+yA+nw4oGoPw1AAlEenn2RTsBA9BhQeYvbu5CDwLLaruDCwmqIGqD3Ta5wbOtQOUNL03mkyCkJojZaFD2sjVRm3LZ0D71zLoA0NE1bfJhB/WMynIgKnG8yF7a9WI0Zde/s9kZkpenMMlqI3HpWrn8e4JAdTcdtl6OiOSGhRwtQ5LAE7ECq8lyH/cwVymJttVDZy4ZpxtY3IdCAnYYvsba8v5Cz8RH/gm2FlnR+CgIsjE2NEPlLYU9gOma4w6hMbZtnctYp6VWgsBg9iXieM5XbgXtdLXagQTmTquG6jk63Qf4AiL9sxChHTNZBSyKQ372A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9781
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d7d20bc5-4560-4a4f-a923-08df0e6efd93
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|35042699022|376014|7416014|36860700016|1800799024|14060799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yqAaFmt7kRFsO6FGvdIbHEPZzB23313NmTK8hq5feJKLIljzyNHVaTc3Kk81MSN4tyamHxEiG0LFeNilNSWgceUNjsawsOMvCuePgEPNS1TfrjRY7DTR3yeB8WVx4ymXeuqsLuaUFW4CapdrIvlgayUbkRdFQGSKI8Fmac/QndgKLa13p37KsC+mzFRIi+VtYgvkm+q1lD2MGH3rcN+24P6gz4mmQm/f+Thn6FlN3LQ8x6nefL65L4sSdPYVa5jC6d+ZhYQzaPAPkeQYOz5Bpaa3klcXq32Pz+KtFDge5POgMUklmaoF2+nU1RQ7qUDWShkk3JdxeR/HYAG0z4QAJYouGrqnwgse51KnHpqjpY3IZAEv2xfUOfgnCjIEy5ZLSCkhkMDpTMkVFoCLsJPUSfrqOuTnTp3l68vNyzxZuJFYsFatW+42Lqab1MvUxGgjASDH9Qe3ZI1/2zdJjw64MIY4gOd1GJ9FfCQJDnEvXdyhYMSHlgyYIX8pJYGadGJ3zB0EheaYerlkbdSwqBKqML/Dm4ua0nlFLNT0FzmAiupVNeyza4HzA4Q7T5FtiKrZ32XWRYa/b00bYqnduscGBH2gOvbq58LcR1+iRMpfRLhBdrSIfuVdeQMi+LII4/9+GLvzNbXIMUDhUyJ7xYBc6l9TtGcF+eVvDcxLla2Q/WGs6AmCW3qJV+HrsNunltlCIgMPof2lzrgUKbDYlA8HbQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(35042699022)(376014)(7416014)(36860700016)(1800799024)(14060799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eQOYpS1Ff4IgfBrIfXvxYTcV0mmV13RCWpNUBJDrXTA3hJpsVOnebcxIET6hOpLcWkhSJDYE+7GVBDECCs2NVCFGWPXMzO6hIlvHprb8GG9+Uud1cDSnlI4rWccEi3D7Ol5K4j3CuAoDjPEKE5bhnL5JE8O6KRY/4cBKYp6VP5kalEAoT04IOwglCmhFGlS3zNWnGuVHQTkgopFKTA12DDdRw6fpWLhRZaakHNDyh/xP+XL3URbJKhfQmonhU5uff7nBOHhrAiGvFKcfwT3h9VrOZ4bKXsCPnd/CgtTpm0Gc+HvrPH6mYTXV+zHEzxhLX5QV7XRC3s0hCIzxW2xQbMZtnHsHkIwvEMXIOPXPofDHAk4OVpN7J82odGpcgH1Pe40Goj0ZZ7yCDWa13mF7ckjQXezc4DQ6hU8ly5zGseq5kMS892h8x66oaDu0JfXt
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 12:37:13.6236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e795de-4e6c-42c6-89b0-08df0e6f1343
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11096
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

Now that eventfd supports __free(), use it in drm_syncobj_eventfd_ioctl().

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
 drivers/gpu/drm/drm_syncobj.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index c23a5de27eff..261d5606e8bd 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1462,9 +1462,9 @@ int
 drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *file_private)
 {
+	struct eventfd_ctx *ev_fd_ctx __free(eventfd) = NULL;
 	struct drm_syncobj_eventfd *args = data;
 	struct drm_syncobj *syncobj;
-	struct eventfd_ctx *ev_fd_ctx;
 	struct syncobj_eventfd_entry *entry;
 	int ret;
 
@@ -1484,16 +1484,17 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 	ev_fd_ctx = eventfd_ctx_fdget(args->fd);
 	if (IS_ERR(ev_fd_ctx)) {
 		ret = PTR_ERR(ev_fd_ctx);
+		ev_fd_ctx = NULL;
 		goto err_fdget;
 	}
 
 	entry = kzalloc_obj(*entry);
 	if (!entry) {
 		ret = -ENOMEM;
-		goto err_kzalloc;
+		goto err_fdget;
 	}
 	entry->syncobj = syncobj;
-	entry->ev_fd_ctx = ev_fd_ctx;
+	entry->ev_fd_ctx = no_free_ptr(ev_fd_ctx);
 	entry->point = args->point;
 	entry->flags = args->flags;
 
@@ -1502,8 +1503,6 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 
 	return 0;
 
-err_kzalloc:
-	eventfd_ctx_put(ev_fd_ctx);
 err_fdget:
 	drm_syncobj_put(syncobj);
 	return ret;

-- 
2.55.0

