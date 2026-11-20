Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8F60A2611
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rLehrvUN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAFE91129C1;
	Fri, 20 Nov 2026 12:51:11 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9680610E8B4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxHYtdFciGPSmPfFvqcQUcNlaj55CAEElbvQwcA1ym1MurNxGqzrCm7K0T2dcXKQrumsxsQTNPKZzIzCPMZ3VfrnOiFVPj7YyvFjm5+97YLiDpqhDJRcxca36OTS+o2QF/DI/qpW43XHRmIlq3WGpGrMysVEoVidMMSt3xikXUeve64evPQ2Z8mLrkzQ5noPiIZy5BK9OQKhw23aKwfr66pa/n0qI5WX7Cb8zHMERLRtGSVl9tivcweclikeYygjBCmGQqa0F2zPOWBjYafSPFpvIX6R36U3FfRqm1a2WRdEbUwV2oguXgIFJQ5qUIRnyrW29LqOD4a1Ebk0rP5jiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3p1SmizF6oVgyKgVR5yC307HOFpDAEdc6K6JHEykmE=;
 b=PHV8gxwE7hx+vOrpdNbAs2Z2U4Iv3Rm753EUCAtE1YglIn4lMW87wzhWblHyG6UujJ23pjZD2wAdXco6x4h9iqJ9Q4+spN2xX+kG/VUS7Z3EqKlRKF/F3sjpCVbEgIj0CrQmGzngOc1FTTk0vPKqvmamFoLk3eOSLBCKSxES8FcTHUgVYS0WNhVh1J3BEK7z9UKgpggN956vKrHgiwZYcyUY0km6fdDa3fXRmWR6ARJjDkSwBAX4V6GGweeABZFor6iIiSsuGbEMCz8zAnpMg38nm7ewEMRxm80cPHp3yOqfPKSYq70zDcJ3dvoGkaXaMYdYoVrr6Px8s7rWbWY4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3p1SmizF6oVgyKgVR5yC307HOFpDAEdc6K6JHEykmE=;
 b=rLehrvUNFoZvAleoOOKlN2kGAo2x9BDOW+cYa0fAZRUMga8PA0OtXJOEU3UVfTM7OtRMlRq8cYhO6f7JViEjA6IfZWyUsZkEDMACHyolsOlylewWaKTJX98T91eFhQwlOoZs7/Jt6YENneTtmKrZ+sNuqjrWJL0hs3FKmmBHBe7N+YyI8SF3kWSABbF+mQ1uC4NjMrl+Pp5lYxb+8fjaTJ20uvvdAifRhQaBi2V1BB4oCW/UeqIC0nWHfaGY7cysEia+Jg7HAwijLsGWtvjti94zoCnQcH8+5AZbpLwSTv9yLiXirhZl9CtuPf+7BXVt5a2uY63GI8fi8sfx72l6wA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 12:50:59 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 12:50:59 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v13 0/5] Add support for i.MX94 DCIF
Date: Fri, 20 Nov 2026 12:50:35 +0000
Message-ID: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260602-dcif-upstreaming-fb177f3c9351
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0027.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::16) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AM0PR04MB12051:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e75553-7822-461b-8bba-08df4704ed13
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|1800799024|376014|7416014|18002099003|6133799003|3023799007|921020|261028144727099003|11063799006|56012099006|261026140227099003|261026121527099003|261102123227099003|261022113327099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6LsIgNiS/4SWvvYU9WBEqWPlWX04MyDTSdTnDor/EnUdiSwo2j3uZr060ShQkgIbrq27LIb/MQwtceMX4PgKwXJvXdKVkdi+WcNkrMtdJcRARvUsgYjO7HJ+Kearm3avE4ydjHEcCNK1eoaYPKNlhyjEir9zqauS20iIfVlHS6mgi5y5bmijslTe9eVNet8a7SOKw0VevHiaqVZrMI0zYPr7eee0hBZeJ24D/a5p3ZTdNXZ01Ow4oKk/haXSK0gbos13GfJnTFzAUEfn2hd/9fd2qOz599vSNnbCSK91M+qMgw8SCGUy+ATk9DC1Rrr5t1BhzzX2q7kEfiBpftQYzz8Y7sW4T/rCfg0+beewV2Oxjv34yXg77pd4e3LQoepqbhbe/WqmDrweAonSchNhwv3zEHDWtsrPMoZ0wI1QW3D0CmNJxurkj/kVHMyDR4Fbz/KgkZilskJmJaKtFJyIMC6QxOSpg2mPXcvoFjuIDU5f8cNCnZ9GnGmeZrbkADtlF5IrSZd0/aQU8GReYydDpf3NBYaQFB1/VKtGXoNGajM46lWIr1SqLdMQx/EQJLYd2CL5VnClySheWnDzcp3v77kkQKUeE/8kKkhlLCKTscOoXhnGa9V46qiQRtij5FOQXM8/tEZLm+8FN/PLlbC6GzJvtvrly3d++50z/gO96DQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(6133799003)(3023799007)(921020)(261028144727099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261102123227099003)(261022113327099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RCtDR2h6UjNGRTVhaTY1ZnFEdGJZVFd1VnF1ZGtQeXdVcy80S05PSkxDSm5P?=
 =?utf-8?B?eWlVWEZYc2UyRm5BZXI2RjFQZnBsZ3QzR2d4N1BaTlJ0RlRReUNLVm9UUjc4?=
 =?utf-8?B?cVU2bk9LaVVJVHRrNTBGT3VsbmNQWDcrdEkvbmk3SFR2azdkWFpqMGdJZWVO?=
 =?utf-8?B?UkFzRE9OT0E4cm9rVGxvRmJnWFBCNVg1bE1NZlp1eEtvN0kvSzIyNy8zeXZi?=
 =?utf-8?B?QjRrNU9obXZIQzJwdFEzYUtHTy9heGZkMThDM3JzTzBrQzZ1RmhPVzFRcW5X?=
 =?utf-8?B?OVB2ajdKWXdrNy93ZWNvbXF1OEFOQ0Z2bTRmeU54dmdVeVZ5Y2o1QU4zSk50?=
 =?utf-8?B?UGxKQWtRZTJKT0RZakVDYmhQaHQ1MG9tU1RKSEgrUDVxdTNoUmVsdnhEcW1H?=
 =?utf-8?B?R3E3TGd3QkE3SmM1UzdwU0NncFYwRmZwN0x5R2ZOcXhReko4cjJFUittL2E2?=
 =?utf-8?B?bndlU3BwbkpxZDJTVWFBa1E1TURmaHhaQmdLd1hlSEhSOVJYMVpWbWZDYjdE?=
 =?utf-8?B?Um45NlcyZ1FnZ2dvZml0aVdRUUJYbGZyQm9VbkYyeC9nMjJHbUlSeGlJVVc4?=
 =?utf-8?B?RHppOWZVQ1gvMUJIVFowZDZVSGVhVlNrMWZKSGRQZzlScnBOTmZJVVQ4S0Vo?=
 =?utf-8?B?cjNYbFhSa29jM2gveWE4bGFIbWxNNFlpeXUrR1ZiL0dQUnhOYjNvbnZkTSs5?=
 =?utf-8?B?UDlBa2M3eW5HVDI2ZkRZVHhmUkNYcjVSM0Y5Z25ZR3p6RUlnNEV2SEJMRmVl?=
 =?utf-8?B?MUg1WlhUK1VRZmdHNVVTODREZE9UMk00Y2t6WFVlUk5tM3JhUXBoNms4ZzVl?=
 =?utf-8?B?bXVNQnZ4ZVFpSVorMXlpa0tIR1A5S2o4enJJVW54aWovRlVIdWZmcFl3TXBQ?=
 =?utf-8?B?VU9yUy9GQnEreFBibzhpbTZmd0JDdGV2bjhpK2dwRkZzNC9oQ1B6STNmV0lv?=
 =?utf-8?B?YXJTSUZTajZXNCt3Ym1jME5rT1pJV2pYWS9UZFdGOXR0UStETGh2YzBIY3VH?=
 =?utf-8?B?SnZ0RXgrRUZwdElkWnJ1Z3hQSDViWWdZSVd5a3V3ODU2ZGhkRTRUaHJXZFkw?=
 =?utf-8?B?UDMvZmo3dlRWTjgyNjNjNVNaZWNPWFd6OGNYSlhBQkYvMndMaFd6VFFPaTdE?=
 =?utf-8?B?dlJJVmptb0hiWXBUWDQxZkI5cTZJWmZISXBWcVp1SitMR09tRGVSYXd3SEhM?=
 =?utf-8?B?Ykp4UXhtTmhkamZNWW4rSmhqYU5IUzFOSHdvb0NERzJ5ME91MzFBODd1M2la?=
 =?utf-8?B?QzZVeHVqMnhjL3dubFkzd2xoM21zOURZMmJ2T2JKNnpSVW52T3RkQUJwc1dN?=
 =?utf-8?B?bE93M1hqeE1CeEZOYXhZRlgyZ1orTFhGd1E5a3Z3dGJINHV1QTBialYxSk1D?=
 =?utf-8?B?RXc0VlJQUmhLd3MwOVpRS3RDUUIxZ3l1bVhHVzJKbjdHKzExZ013NDJUeWNp?=
 =?utf-8?B?WkIzVXZDS1NsS3lLUSswQU5TU1ZWUlkwMkdCZFk0SnZUWWgrRkFseEJZUWx4?=
 =?utf-8?B?bEJsS3ZjZnV2eGdiMkR4VWZZbEJkc01nV3puYVY0NG5NMGNiMUY0L1lNODhR?=
 =?utf-8?B?L0M2M25NRzI5TlZFVWVoRFVMSm0xd1d3RjB6VVV1T0QxajR2NS81d2FnanBa?=
 =?utf-8?B?Tlhydm1VWFlBck1YOTdWOGc2UzhlOEJFVXZVL3FCUUpGZ2NEbkhTM1dKNUp2?=
 =?utf-8?B?VENzSWNGT1ROWWJHTFE0Nmw0MGZVRE9vRUsvb2VCd1JVRno0Qlo4R0VMYTUz?=
 =?utf-8?B?dXlOK0JqdkEwc2JGWjN1Vnh4SVc4cThTRkFSVEdOTDQyM3pEOHpvVHA3cmYy?=
 =?utf-8?B?MHp4dzE5ckxYeDIycERRdUE2Zk5wenQwRjZUSkNRcjBZL0p1amlFeVJaWjJS?=
 =?utf-8?B?dzA3YnNjQmtwUmFNTzlQVk43eHpDcVdHU3JRTjN2LzY1VU5MUmZYQXpFaU1p?=
 =?utf-8?B?a3pNVVlhUjUxQjlPT2VTY2VsdHQyRjVFL080ZjVaN1o3SFdra2dKQklOeW4w?=
 =?utf-8?B?dzc0Mzg5QkZZZTM4UmdxbHBka000WnJSeFcvSTkxcVZxeUw1NUNwSUhmdGlI?=
 =?utf-8?B?blROcjlGNlZVRW9aalVMN082NTZJOFMvbit0enVVcTdheGZpMDdxN0N3alNC?=
 =?utf-8?B?MlovWE5hMkd1N3d5QnQrRWdoWklUM0pQQ2dBU2lseG5ubmtkRDI1YWZIS0Nn?=
 =?utf-8?B?K0NqYlV3dzY5WHc4cTVVbXBtUFQ4SHFJYUVPMFl6bW03R3ZSNkVKdi9yUG1H?=
 =?utf-8?B?KzJyc0t2RFF4QWs4SGRZTU8zRDdjSmNtbGlpbnFtaXNabDUvRXE4bkFQN2NY?=
 =?utf-8?B?eTA4Nm5hQnFkV3p4NHFyS1VmREwzdktUU0xnVk5FOVRSRGQzWHhiWUU2OTY1?=
 =?utf-8?Q?ZM7kZSI3SUU+Afq4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e75553-7822-461b-8bba-08df4704ed13
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 12:50:59.6149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZNi7BCwlkZ4Ak7kaeDBr2OHadixXDPj+mt9mg4Y3C5rzfmurnRv+fPZEKZYCPU4VoVNfVCvsTO9vxl6uLhrCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12051
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This patch-set adds support for the i.MX94 Display Control Interface.

Thanks,
Laurentiu

---
Changes in v13:
- Rebased to latest linux-next (next-20261119);
- 1/5: No change;
- 2/5: When disabling the CRC, also clear CRC_TRIG and set
  CRC_SHADOW_LOAD_EN. CRC_EN is shadowed, so the disable was never
  latched, and CRC_TRIG is not self-clearing in continuous mode, so a
  later re-enable did not write the register (Sashiko). Sashiko's
  comments about register access and unbalanced clock disable when
  runtime PM resume fails were not addressed: the only failure point
  is clk_bulk_prepare_enable() and the clocks are managed by the SCMI
  firmware, so extra checks would only add noise. See:
  https://lore.kernel.org/r/awAgaVs4LLwqVA57@vm
- 3/5: No change;
- 4/5: No change;
- 5/5: No change;
- Link to v12: https://patch.msgid.link/20261118-dcif-upstreaming-v12-0-29b35e27a1cc@oss.nxp.com

Changes in v12:
- Rebased to latest linux-next (next-20261116);
- Dropped the fsl-ldb patches (v11 1/7 and 2/7) since they were applied
  to drm-misc-next by Luca and are now in linux-next;
- 1/5: No change;
- 2/5: Take a vblank reference while the CRC is enabled, otherwise the
  VS_BLANK interrupt gets masked on a static screen and reads from the
  debugfs crc/data file block forever; always stop the CRC when the CRTC
  is disabled (Sashiko); in the IRQ handler, only handle the status bits
  that are enabled in IE0/IE1 and return IRQ_NONE when none is pending
  (Sashiko); reject negative ROI coordinates in the CRC source parser
  (Sashiko); propagate runtime PM resume failures from
  dcif_hw_probe_init() and call it after KMS init, so the hardware is
  not touched before the bridge lookup can defer and before the
  supplier device links are created (Sashiko); reject framebuffers whose
  pitch does not fit in the 16-bit CTRLDESC3 pitch field (Sashiko); use
  of_drm_get_bridge_by_endpoint() instead of the deprecated
  devm_drm_of_get_bridge(), and drop the DRM_PANEL_BRIDGE select and the
  unused drm_panel.h include (Luca); declare and initialize the __free()
  bridge pointers in one statement (Luca, Sashiko); allow COMPILE_TEST;
  update the copyright year to 2026 (Luca);
- 3/5: Collected Rob's r-b tag;
- 4/5: No change;
- 5/5: No change;
- Link to v11: https://patch.msgid.link/20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com

Changes in v11:
- Rebased to latest linux-next (next-20261109);
- Dropped "drm/bridge: fsl-ldb: Get the next non-panel bridge" since the
  driver already gets the next bridge after upstream commit 802372cf316a
  ("drm/bridge: fsl-ldb: don't create a panel_bridge") (Luca). The
  remaining cleanups suggested by Luca were sent as a separate patch,
  not needed by this series:
  https://lore.kernel.org/r/20261030163254.3175671-1-laurentiu.palcu@oss.nxp.com
- Dropped the standalone MAINTAINERS patch. The entry is now added
  together with the DCIF binding (3/7) and the driver (4/7) to make
  checkpatch happy;
- 1/7: No change;
- 2/7: Collected Luca's r-b tag;
- 3/7: Add the MAINTAINERS entry;
- 4/7: Program the plane registers (format, size, pitch, base address,
  layer enable) only from the plane update path, no longer from CRTC
  enable; arm the vblank event with drm_crtc_arm_vblank_event() in
  atomic_flush and drop the driver-private event caching, which fixes
  the vblank refcount and early-event issues; on probe, mask and ack the
  interrupts left enabled by the bootloader, and request the IRQ only
  after KMS init to avoid a NULL CRTC dereference; dropped the unneeded
  mod_devicetable.h and drm_fb_dma_helper.h includes; style fixes in
  the of_device_id table and platform_driver initializer (Uwe); follow
  the reference manual software reset sequence: wait for the DPI to go
  idle after clearing DISP_ON and hold the AXI fetches (AXI_RD_HOLD)
  until the pending reads are done before pulsing SW_RST; stop the
  controller at probe if the bootloader left it running; add device
  links to the display CSR and the LDB to enforce the suspend/resume
  ordering, which fixes a vblank timeout after system resume; include
  <linux/bitfield.h> in dcif-reg.h; in mode_valid, reject modes larger
  than the mode_config max_width/max_height and modes whose porches or
  sync widths overflow the 12-bit DPI timing fields;
- 5/7: Renamed the 'ldb' child node to the generic 'bridge' node name
  (Conor);
- 6/7: Renamed the ldb@4 node to bridge@4 accordingly;
- 7/7: No change;
- Link to v10: https://patch.msgid.link/20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com

Changes in v10:
- Rebased to latest linux-next (next-20261005);
- 1/9: No functional change;
- 2/9: Switch to using of_drm_get_bridge_by_endpoint() helper for
  fetching the next bridge;
- 3/9: No functional change;
- 4/9: No functional change;
- 5/9: Fixed a pixel-clock unit mismatch bug, ROI now derived from mode
  at program time, CRC reprogrammed on ROI/source change, bus-format
  validated with a whitelist, forced modeset on CRTC activation
  (dcif_atomic_check), vblank event flushed on disable to avoid hangs,
  dropped PREMULTI blend support since PREMULTI is not mandatory anymore
  and the display controller does not support it, probe error paths
  checked, shared dcif_set_csc()/dcif_plane_disable_layer() helpers
  introduced;
- 6/9: restructured to reuse the existing conditional schema pattern for
  the new nxp,imx94-lvds-csr compatible, instead of unconditional
  properties. Dropped Krzysztof r-b tag as it needs reviewed;
- 7/9: No functional change (context shift);
- 8/9: regulator nodes relocated/renamed (reg_1v8_ext/reg_3v3_ext ->
  reg_1p8v_ext/reg_3p3v_ext) to match existing naming convention;
- 9/9: No functional change (context shift);
- Link to v9: https://patch.msgid.link/20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com

Changes in v9:
- Rebased to latest linux-next (next-20260611);
- 2/9: Reworked to store the next bridge in fsl_ldb->bridge.next_bridge
  (taking a reference with drm_bridge_get()) instead of adding a new
  dedicated field. Removed the r-b tags for this patch since it needs a
  fresh review;
- 3/9: Fixed the i.MX94 LDB max_clk_khz limit (165 MHz -> 148.5 MHz) to
  match the actual hardware limit. Removed the r-b tags for this patch
  since it needs a fresh review;
- 4/9: Added a 'required:' properties list to the binding. Removed
  Krzysztof's r-b tag for this patch since it needs a fresh review;
- 5/9: Renamed the CRC source helpers (dcif_crc_source_*) and made them
  unconditionally available, dropping the CONFIG_DEBUG_FS stubs;
  improved CRC source parsing (auto ROI for the full-frame source,
  unsigned params, safer string handling); rebased onto the
  drm_atomic_state -> drm_atomic_commit rename in linux-next; reworked
  CRC/modeset gating with new has_crc and crtc_pm_enabled flags and
  proper PM error handling; switched event_lock to spinlock_irq; removed
  a redundant connector-attach call and fixed an error format string;
  added new pixel formats and full alpha/blend-mode support;
- 6/9: YAML quoting style fix only, no functional change;
- 7/9: Combined the former "arm64: dts: imx943: Add LVDS/DISPLAY CSR
  nodes" prerequisite and the "arm64: dts: imx943: Add display pipeline
  nodes" patch into a single new patch targeting the shared imx94.dtsi
  instead of imx943.dtsi, removing the dependency on Peng Fan's
  not-yet-merged patch;
- 8/9: Renamed the IT6263 bridge node to 'hdmi@4c' and fixed its
  reset-gpios polarity to GPIO_ACTIVE_LOW;
- Link to v8: https://lore.kernel.org/r/20260304-dcif-upstreaming-v8-0-bec5c047edd4@oss.nxp.com

Changes in v8:
- Rebased to latest linux-next (next-20260303). Patch 2/9 had a minor
  conflict bacause of a patch introduced recently;
- 8/9: Fixed CHECK_DTBS errors reported by Rob's bot due to missing
  regulators. Removed the r-b tag for this patch because it needs a
  fresh review;
- Link to v7: https://lore.kernel.org/r/20260122-dcif-upstreaming-v7-0-19ea17eb046f@oss.nxp.com

Changes in v7:
- Rebased to latest linux-next;
- Addressed some new checkpatch warnings: kzalloc -> kzalloc_obj;
- Fixed a couple of static check warnings in probe();
- Added Luca's r-b tag for bridge refcounting;
- Link to v6: https://lore.kernel.org/r/20251103-dcif-upstreaming-v6-0-76fcecfda919@oss.nxp.com

Changes in v6:
- 2/9: Collected r-b tag from Francesco;
- 3/9: Removed ch_max_clk_khz variable as suggested by Luca and added
  his r-b tag;
- 4/9: Collected r-b tag;
- 5/9: Call drm_bridge_put() automatically in
  dcif_crtc_query_output_bus_format() by using a cleanup action (Luca);
- 6/9: Moved allOf: block after required: block (Krzysztof). Collected
  r-b tag;
- Link to v5: https://lore.kernel.org/r/20250911-dcif-upstreaming-v5-0-a1e8dab8ae40@oss.nxp.com

Changes in v5:
- 4/9: Removed "bindings for" from the title, changed the port
  definition and simplified the example;
- 6/9: Fixed the way 'ldb' child node is declared: declare the
  'ldb' child node out of if:then: block and set the property
  to false for compatibles other than nxp,imx94-lvds-csr;
- Link to v4: https://lore.kernel.org/r/20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com

Changes in v4:
- Addressed remaining DCIF driver comments from Frank;
- Limit the 'ldb' child node only to CSRs compatible with 'nxp,imx94-lvds-csr'
  in the binding file. Since LVDS CSRs are a minority, I chose to
  use the if:then: construct instead of if:not:then:;
- Remove the '#address-cells' and '#size-cells' from the ldb node, in
  imx94.dtsi, as they're not needed;
- Link to v3: https://lore.kernel.org/r/20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com

Changes in v3:
- Removed the BLK CTL patches and created a separate patch set [2] for them;
- Collected r-b tags for 1/9, 2/9, 3/9 and 9/9;
- Removed the DCIF QoS functionality until I find a better way to
  implement it through syscon. QoS functionality will be added in
  subsequent patches. Also, used devm_clk_bulk_get_all() and used
  dev_err_probe() as suggested;
- Addressed Frank's and Krzysztof's comments on the DCIF bindings;
- Addressed Frank's comments on dtsi and dts files;
- Added a new binding patch, 6/9, for adding 'ldb' optional property to
  nxp,imx95-blk-ctl.yaml;
- Link to v2: https://lore.kernel.org/r/20250716081519.3400158-1-laurentiu.palcu@oss.nxp.com

Changes in v2:
- reworked the BLK_CTL patch and split in 2 to make it easier for
  review;
- split the dts and dtsi patch in 2 separate ones;
- addressed Frank's comments in DCIF driver;
- addressed Rob's comments for the bindings files;
- addressed a couple of checkpatch issues;
- Link to v1: https://lore.kernel.org/r/20250709122332.2874632-1-laurentiu.palcu@oss.nxp.com

---
Laurentiu Palcu (4):
      dt-bindings: display: imx: Add i.MX94 DCIF
      dt-bindings: clock: nxp,imx95-blk-ctl: Add LDB bridge child node
      arm64: dts: imx94: Add display pipeline nodes
      arm64: dts: imx943-evk: Add display support using IT6263

Sandor Yu (1):
      drm/imx: Add support for i.MX94 DCIF

 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |  24 +-
 .../bindings/display/imx/nxp,imx94-dcif.yaml       |  90 +++
 MAINTAINERS                                        |   9 +
 arch/arm64/boot/dts/freescale/imx94.dtsi           |  82 +++
 arch/arm64/boot/dts/freescale/imx943-evk.dts       |  86 +++
 drivers/gpu/drm/imx/Kconfig                        |   1 +
 drivers/gpu/drm/imx/Makefile                       |   1 +
 drivers/gpu/drm/imx/dcif/Kconfig                   |  15 +
 drivers/gpu/drm/imx/dcif/Makefile                  |   5 +
 drivers/gpu/drm/imx/dcif/dcif-crc.c                | 238 +++++++
 drivers/gpu/drm/imx/dcif/dcif-crc.h                |  54 ++
 drivers/gpu/drm/imx/dcif/dcif-crtc.c               | 710 +++++++++++++++++++++
 drivers/gpu/drm/imx/dcif/dcif-drv.c                | 250 ++++++++
 drivers/gpu/drm/imx/dcif/dcif-drv.h                |  90 +++
 drivers/gpu/drm/imx/dcif/dcif-kms.c                | 181 ++++++
 drivers/gpu/drm/imx/dcif/dcif-plane.c              | 300 +++++++++
 drivers/gpu/drm/imx/dcif/dcif-reg.h                | 270 ++++++++
 17 files changed, 2405 insertions(+), 1 deletion(-)
---
base-commit: d785d132202e8e8e93335ebf74ad5b29fca0951f
change-id: 20260602-dcif-upstreaming-fb177f3c9351

Best regards,
--  
Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
