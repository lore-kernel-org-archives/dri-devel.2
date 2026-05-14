Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6A5CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 10:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D996E10E37F;
	Thu, 14 May 2026 10:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qw01H8ar";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6107010E2EE
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 10:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN5OKAah+PZ9xcAcaclCplt39O5HlpSolkux8Soh7FeIUj1Y5jgYQ6caFbo4sy5qJYh84c8TAdZsaPYmjdt2h0SsnhlF5WZWTMZ17axhlAFdmEmwsTT4rJkvt6nScsYfLgnYaQIe4HgczlimJvQphb5fGDUitjM9H9hDNqFuUObu0vFdMYWWwVT1UTNx+5ANdakVDbB5VYYjTFkUoN4pKw8qdqBOrkPESIS2isg/CLPLojUu0jFaD3wOkO+MtsripRtNQCvzBY3PxNBKPFrV4UoQf/RpgV+xxps2whmI6SR3M9WiCuL0eDggQnKavn/qIIkIrhunbd88oWxxLr12uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQiJSUYg5w3VFHUXKt4qg6+yTxqMkct1ZrtYCO440Q0=;
 b=DhRJNEfpHQt/DybkAU9IbCC6TZInwx/TXCIg7lUDGrSEWmkrrPWPKRI1YT3yIZ7IJfPzGbBY4ytXQg/+RVDBBy2e733fSLzYgaGhyIgmc3S+vT3XjtMwQJ4G3l4H7vpFVUJh0xZk8xuRfmeAkgS60FClum9jKkgmZ6tXMpNKGRuldggQBdOBYOZMHSglm1TW8Wdpx12MSHKG+lpQMcs92AKapogB9nYgdoYkt5Caw2urRE3kjPyYsVwnPwJoLXdHAmPnRUztCT/ibB4ncloyp7Y5UdDRQuysAInnBZPfa+3hOLuWDmO56Ru9PiaiApiEF4o0nUsftahmxpPbtbm3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQiJSUYg5w3VFHUXKt4qg6+yTxqMkct1ZrtYCO440Q0=;
 b=qw01H8arf5oQd0iEk1nhK+oOVZmjRZFJ6sSepGYyUHC/51f+t1esIWB9tt0YRlg3HTXfQD1VFSk0mxiAqR1tgAjdwzCTROML1fsXqAb+3n01lo9jLXCxC2Rg9nGpBMqLfMj2auh+7Z8HL29VjXCfehgK6CsnhqVQ5GASgVy8c21hs+5KmJUSLfCuEUxb3uU+Uqz0sZAynxy1l6MNR/wY2G5lu942CpI3SfCk5jb1YbeKyFlTaElU++1O1HL1xJICy0rnuQFQCI+byS75cmdT/xIUh+1ifUjV2gr2NVJAnwYiFuSCYX5lYxmkmIv3Zt/+RJm+AmLLXilsp+vLIeyG1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15)
 by SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 10:32:31 +0000
Received: from MW4PR12MB7000.namprd12.prod.outlook.com
 ([fe80::43ba:fd2f:56b9:7387]) by MW4PR12MB7000.namprd12.prod.outlook.com
 ([fe80::43ba:fd2f:56b9:7387%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 10:32:31 +0000
From: Tanmay Patil <tanmayp@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tanmay Patil <tanmayp@nvidia.com>
Subject: [PATCH 0/2] gpu: host1x: syncpt_wait micro-optimizations
Date: Thu, 14 May 2026 10:31:51 +0000
Message-ID: <20260514103153.766343-1-tanmayp@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::33) To MW4PR12MB7000.namprd12.prod.outlook.com
 (2603:10b6:303:208::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7000:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd13c65-7e25-4c8a-2c84-08deb1a41ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 17wJF9gy+mzInmTUVge8NlRwJduHQLXKnePY0Ru8EiVaGUrNjOcrK55XzXQw8zySv+T87JIEggb5mirPm4/9cBfT0FnhMItonKecqI+sejONKl+IkAdHu7hW6SSBJ7asZSM1g6EC/NHpYL8P+6dCV04hS61GUaeawyYMHM7PmnxOdzkSxMdfEFZrFAxVQx1CoPs7ZEdBSbLfXldVhfeZGWk2EZ5Oy0j9ZAJk2q+1cnz6V05BLCh2HZBeSPxn0Sk3drO9Zh0K7tcRjLNLbhHkQu2AnIGXnlT4TRW/Gbu/cy2QIP5WWz8yuslTPcB8WZn8PCh+pepbD81Uatsm/PM+xdtouzi/mzCePkeKNDlOuIhxibqF8FELKMjQq1MbwlW4uPzefrSky1+yvcXnbOckU03gAkPuM7rNxjW6eSi2iDbCs4DZfWZOUn7EJpzgAL42ChghAJZSx/OSubwKlHPX8XrGYApQFJbQ0t8JCEOcHnZwJsHd+vEhF1oJy4Tc76LukKdlFOIpAcwlgmkgtF7ofJsHVcUDo3NYqcaSn1ZwDlf5Y5MWFuvLOstcRDyk2CIaErQ/dAiH7BkMpcM+BsSoTdB/TmWgXvHkjZPkETl/aaS5vVGb1AChN/SS/Un7R+JKQMAf7ipBOETR4dnQiCXMwhsv2ZnC4ipmFCXuwR+R0g/oyZuzluAx9xj6cQpS+hoa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB7000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rcCAvhlfq829e6FRbDBdrONIWCRJtaS1oBqOp8mYL09MN6N3Yndm+CN1keg4?=
 =?us-ascii?Q?FEYLNn15D/YuxpbiI0arBPcdBcKxT5a0TcPDUQ1zvXjr0+CWJ5bV4K0Ks3N3?=
 =?us-ascii?Q?8jMOO8zL9fkbmwl/Vo25YOGXrD9Jgt3HaXqPwAPWWOPtl7+YYk50L8VvSm2R?=
 =?us-ascii?Q?Vz8AVe46rTFpNVusqjQ0GIgUXAMOQ0ixr3VWwVvgcAK1EhNTkxMFYJeaDz8B?=
 =?us-ascii?Q?hnYPYNnPTDYdfZQ8KWXc2r6qMsVyZeHV08lUunMYzLn7nlFqxg1Ep9ZSE8hj?=
 =?us-ascii?Q?yOFoyWFTP6JzBh2rMVUPekDWTnZ2HTtiyrPHhFWxVQbq/QQoPN94PpcAkO2f?=
 =?us-ascii?Q?w9GMEBrava/b/OlR+WJ7GzbvCXv6A3Rva3zZzke3zbaSfuXpCUjanrS/QNJQ?=
 =?us-ascii?Q?ELBXCAuNUB32VPQRaHf4DxA08UQU7sHY3kYZET+fSZj/x52QnxQyB7DYy6n+?=
 =?us-ascii?Q?luwsMKeEJTfiPmuyJBcOfPPt39oduyivu/bepuoqiBpbTcEVVNsnZJoH9jfW?=
 =?us-ascii?Q?FkR3aQYpikzlZ6vMumDhY63oYd8fC0QNnd4Huu/hTQ/y69pq2WqT9ds5GD7O?=
 =?us-ascii?Q?cxEWmtfomm0kjcHBsvSlpCHzFJFOQrZL8QbSyl8uEa9MSI0VF0YGE37qGJGb?=
 =?us-ascii?Q?kWP29XHHz+YqkzCA1gB5SOfQI/BNAw+Ur5/YWtsvF7Euq7uPvpfJjjUvZsEk?=
 =?us-ascii?Q?O6AxIKD8e5jchbMoYQ8SY5wW4pEJI/CtUylf6nBXICLdG5ITsztx+SpgYDwE?=
 =?us-ascii?Q?OcWgEPl7mlT6JdG1W/I1Yq85+sQa0hxCrYiquspSS78fAQ5zrT0KwB6lOCQ0?=
 =?us-ascii?Q?C1j7+Ko2nJY8/gCR47NIQwsQWI270ln277BX9xrFFNTfk8WY8sDCgLa7QExl?=
 =?us-ascii?Q?eGEckX12Vlud9knJDXCe/WOwwnNVvyJpEc8nL/H4XsCg3cvZR9y1uX2GLb7N?=
 =?us-ascii?Q?m//u4tY756RPwNdIVyMwqmnL2FvphxiHMQEmEPiIbWMoK/pQfNMCwBkJWR4i?=
 =?us-ascii?Q?D4jfLYkWiTU0GRdi9iWTBKqq143Z4TX4TpHdOQ+fyHMlhZzbYfU8/Nl0djLL?=
 =?us-ascii?Q?1jvHq2Gmu0dt6m3Ql9wgnusGYwXUJ3ABvkX9RDuwj/KIZv/7aAcUHKDMj3Y9?=
 =?us-ascii?Q?nJm/cQJF6zLqQQSFnaUWbZ2Vn/0/eJU7MrQNKJf431GjcU0xZ3ZlCvFKxhgY?=
 =?us-ascii?Q?7tdQA2c2jbh7wH9nAnZX9aC5fHAfjcfiiDsX48RHlVPhJmumJGh96ohtIe6C?=
 =?us-ascii?Q?gR8dbjnkc7f7/Eb/KBmLmmAz80Y94xoohwYy2yrgvfmXOeFjoYbyI1dpVnAb?=
 =?us-ascii?Q?WAeA0+0wmCn8OljFYk25FARY9SWLvZ3U+Jxrn/XT/wyWl61pF7ztNr2TS2O5?=
 =?us-ascii?Q?vjFy8SkVjG5GRxmMbp2n7KOu08BJ33TXQrj/taTxg2gdaNT/yYbJkCyjjM2x?=
 =?us-ascii?Q?/TBgHgRJheproakZIvsD/wx4i3BwtPibaTnoXCaV/+1orXgsdqqZa1VqlcIW?=
 =?us-ascii?Q?HINQShW57i0+Q08v6UU9OseLgBdqExLrXO89h8jC7Hn9A0k6HtLoQ856Ihsy?=
 =?us-ascii?Q?Ti0oxImPazqhsRkrNeZsUh0iwgliny3BYIXMF3QjeSVTud7LV1y55KUXW2jt?=
 =?us-ascii?Q?tvAmv9YeSRUJz9Bh+HN+eReGj0Y63znJBODektS7QFtBCzscCv5kpzZX6f8E?=
 =?us-ascii?Q?QJUwJ6nLLWDdQHf06tDvQSVPIUgqpepY6kFcq6y/V3Prg+yQh6tZv1/W/NkG?=
 =?us-ascii?Q?D36Hw26VPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd13c65-7e25-4c8a-2c84-08deb1a41ab9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:32:31.5765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Wc5AFhtn6VGdsWxKskLAQy8H9VttGxUt7Virx2GPSftcGRLV5RcRnJAHDSVAsX1TBHl2u+lxr+uMO1CYnCURg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179
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

This series reduces the latency in host1x syncpoint wait path.

Patch 1 removes redundant MMIO reads in host1x_syncpt_wait().
Patch 2 skips the host1x_intr_update_hw_state() call in the ISR
when no fences remain.

Measured syncpoint wait latency (50000 samples):
  Average latency:   12.2 us  -> 9.4 us
  99.99 pct latency: 62.96 us -> 36.58 us

Tanmay Patil (2):
  gpu: host1x: skip redundant syncpoint loads in host1x_syncpt_wait()
  gpu: host1x: skip redundant HW state update

 drivers/gpu/host1x/intr.c   |  8 ++++++--
 drivers/gpu/host1x/syncpt.c | 23 ++++++++++++++---------
 2 files changed, 20 insertions(+), 11 deletions(-)

-- 
2.54.0

